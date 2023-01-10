-- file: ch16/csv1.hs
-- import Text.ParserCombinators.Parsec

{- A CSV file contains 0 or more lines, each of which is terminated
   by the end-of-line character (eol). -}
-- toolVersionsFile :: GenParser Char st [[String]]
-- toolVersionsFile =
--     do result <- many line
--        eof
--        return result

-- -- Each line contains 1 or more cells, separated by a comma
-- line :: GenParser Char st [String]
-- line =
--     do result <- cells
--        eol                       -- end of line
--        return result

-- -- Build up a list of cells.  Try to parse the first cell, then figure out
-- -- what ends the cell.
-- cells :: GenParser Char st [String]
-- cells =
--     do first <- cellContent
--        next <- remainingCells
--        return (first : next)

-- -- The cell either ends with a comma, indicating that 1 or more cells follow,
-- -- or it doesn't, indicating that we're at the end of the cells for this line
-- remainingCells :: GenParser Char st [String]
-- remainingCells =
--     (spaces >> cells)            -- Found comma?  More cells coming
--     <|> (return [])                -- No comma?  Return [], no more cells

-- -- Each cell contains 0 or more characters, which must not be a comma or
-- -- EOL
-- cellContent :: GenParser Char st String
-- cellContent =
--     many (noneOf "\n")


-- -- The end of line character is \n
-- eol :: GenParser Char st Char
-- eol = char '\n'

-- parseToolVersionsFile :: String -> Either ParseError [[String]]
-- parseToolVersionsFile input = parse toolVersionsFile "(unknown)" input

module AsdfParser (asdfStruct, comment, line, toolName, version, content, parseAsdf) where

import Text.Parsec

asdfStruct = do
    skipMany comment
    sepEndBy1 line newline

comment = do
    char '#'
    body <- (manyTill anyChar newline)
    return ""

line = do
    skipMany comment
    toolName
    skipMany space
    sepBy version $ char ' '
-- cell = many $ noneOf "#\n"
-- eol = char '\n'


toolName = manyTill (noneOf "#\n") spaces

version = many1 $ noneOf "#\n"

parseAsdf :: String -> Either ParseError [[String]]
parseAsdf src = parse asdfStruct "* ParseError *" src

content :: String
content = "shellcheck 0.9.0 0.7.2\nnodejs 18.11.0 16.17.1 # This entry exists for test\nshfmt 3.6.0\n"

-- main = do
--   print $ parse (parseAsdf content)

-- main :: [a]
-- main = take 3 [x * x | x <- [1,4...42]]

-- main :: IO ()
-- main = do
--     file <- readFile ".tool-versions"
--     -- let logLines = lines file
--     putStr $ parseToolVersionsFile file
