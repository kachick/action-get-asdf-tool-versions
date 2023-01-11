{-# LANGUAGE Safe #-}

module Asdf.Parser (parseAsdf, toJson) where

import Data.List
import Text.Printf

data Entry = Entry{toolname :: String, versions :: [String]}

-- entry :: [String] -> Maybe Entry
-- entry cells = case cells of
--         x:xs -> Just Entry{ toolname = x, versions = xs }
--         _ -> Nothing

-- Avoided to depend external libraries as aeson and/or parsec

entry :: [String] -> Entry
entry cells = case cells of
        x:xs -> Entry{ toolname = x, versions = xs }
        _ -> Entry{ toolname = "none", versions = ["none"] }

parseAsdf :: String -> [Entry]
parseAsdf content = map entry (map words (filter (/= []) (map (takeWhile (/= '#')) (lines content))))

formatEntry :: Entry -> String
formatEntry entry = printf "\"%s\":\"%s\"" (toolname entry) (head (versions entry))

-- No accurate for some special characters
toJson :: [Entry] -> String
toJson entries = printf "{%s}" (intercalate "," (map formatEntry entries))

