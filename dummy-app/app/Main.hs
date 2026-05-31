module Main where

import PkgA (valueA)
import PkgB (valueB)

main :: IO ()
main = putStrLn (valueA ++ valueB)
