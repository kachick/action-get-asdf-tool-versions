{-# LANGUAGE Safe #-}

module Asdf.Parser (parseAsdf, toJson) where

import Data.List (intercalate)
import Text.Printf (printf)
import Data.Either (rights)
import Data.List.NonEmpty as NE

data Entry = Entry{toolname :: String, versions :: NonEmpty String }

-- Avoided to depend external libraries as aeson and/or parsec

entry :: [String] -> Either String Entry
entry cells = case cells of
        t:v1:vs -> Right Entry{ toolname = t, versions = fromList (v1:vs) }
        _ -> Left "empty versions"

parseAsdf :: String -> [Entry]
parseAsdf content =  rights [ entry x | x <- Prelude.map words (Prelude.filter (/= []) (Prelude.map (Prelude.takeWhile (/= '#')) (lines content)))]

formatEntry :: Entry -> String
formatEntry e = printf "\"%s\":\"%s\"" (toolname e) (NE.head (versions e))

-- No accurate for some special characters
toJson :: [Entry] -> String
toJson entries = printf "{%s}" (intercalate "," (Prelude.map formatEntry entries))

