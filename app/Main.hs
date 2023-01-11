#!/usr/bin/env cabal
{- cabal:
build-depends: base >= 4.7 && < 5
            , action-parse-asdf-tool-versions
-}

module Main where
import Asdf.Parser (parseAsdf, toJson)
import Data.Function ((&))

main :: IO ()
main = do
    input <- getContents
    putStrLn $ parseAsdf input & toJson
