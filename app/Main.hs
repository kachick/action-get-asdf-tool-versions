module Main (main) where
import Asdf.Parser (parseAsdf, toJson)
import Data.Function ((&))

main :: IO ()
main = do
    input <- getContents
    putStrLn $ parseAsdf input & toJson
