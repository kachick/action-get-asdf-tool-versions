module Main where
import AsdfParser (parseAsdf)

main :: IO ()
main = do
    input <- getLine
    putStrLn $ parseAsdf input
