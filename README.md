# Cabal shallow reference reproducer

This repository reproduces the regression described in <https://github.com/haskell/cabal/pull/10254#issuecomment-4586318112>.

It contains two `source-repository-package` entries that point at the same GitHub repository but different `subdir` and `tag` values:

- `pkg-a` at commit `0a944ae6a6fbd7f317487bbe584ee06bc9e51758`
- `pkg-b` at commit `bb26dbf39315493e974443ecdeaf8598c4ca7ac9`

## Reproduce

Clone this repository and run:

```bash
cabal build all -v
```

Cabal should first create a shallow clone for `pkg-a`, then try to reuse that checkout as a `git clone --reference` source for `pkg-b`. The expected failure is:

```text
fatal: reference repository '.../dist-newstyle/src/cabal-srp-shallow-reference-reproducer-...' is shallow
```

## GitHub Actions

This repository also includes a GitHub Actions workflow that runs the reproducer on `ubuntu-latest`.

The workflow intentionally expects `cabal build all -v` to fail with the shallow-reference error. It treats that exact failure as success, so the workflow demonstrates the regression without requiring manual log inspection.

## Repository layout

- `pkg-a/` is present in the first tagged commit.
- `pkg-b/` is added in the second tagged commit.
- `dummy-app/` is the local package that depends on both of them.
- `cabal.project` points back to this repository on GitHub, so no helper script is needed.
