{-# LANGUAGE Safe #-}

module Asdf.Parser (parseAsdf, toJson) where

import Data.List (intercalate)
import Text.Printf (printf)
import Data.Either (rights)

data Entry = Entry{toolname :: String, versions :: [String] }

-- Avoided to depend external libraries as aeson and/or parsec

entry :: [String] -> Either String Entry
entry cells = case cells of
        x:xs -> Right Entry{ toolname = x, versions = xs }
        _ -> Left "empty versions"

parseAsdf :: String -> [Entry]
parseAsdf content =  rights [ entry x | x <- map words (filter (/= []) (map (takeWhile (/= '#')) (lines content)))]

formatEntry :: Entry -> String
formatEntry e = printf "\"%s\":\"%s\"" (toolname e) (head (versions e))

-- No accurate for some special characters
toJson :: [Entry] -> String
toJson entries = printf "{%s}" (intercalate "," (map formatEntry entries))

