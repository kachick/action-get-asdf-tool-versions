{-# LANGUAGE Safe #-}

module Asdf.Parser (parseAsdf, toJson) where

import safe Data.List (intercalate)
import safe Text.Printf (printf)
import safe Data.Either (rights)
import safe Data.List.NonEmpty as NE ( NonEmpty, fromList, head )
import Data.Function ((&))

data Entry = Entry{toolname :: String, versions :: NonEmpty String }

-- Avoided to depend external libraries as aeson and/or parsec

entry :: [String] -> Either String Entry
entry cells = case cells of
        t:v1:vs -> Right Entry{ toolname = t, versions = NE.fromList (v1:vs) }
        _ -> Left "empty versions"

trimComment :: String -> String
trimComment = takeWhile (/= '#')

parseAsdf :: String -> [Entry]
parseAsdf content = lines content & map (words . trimComment) & filter (/= []) & map entry & rights

formatEntry :: Entry -> String
formatEntry e = printf "\"%s\":\"%s\"" (toolname e) (NE.head (versions e))

-- No accurate for some special characters. AFAIK, asdf does not have the pattern...
toJson :: [Entry] -> String
toJson entries = printf "{%s}" (intercalate "," (map formatEntry entries))

