module Asdf.ParserSpec (main, spec) where

import Test.Hspec
import Asdf.Parser (parseAsdf, toJson)
import Data.Function ((&))

content :: String
content = "shellcheck 0.9.0 0.7.2\n\n\nnodejs 18.11.0 16.17.1 # This entry exists for test\nshfmt 3.6.0\n"

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "converting" $ do
    it "returns the first element of a list" $ do
      (parseAsdf content & toJson) `shouldBe` ("{\"shellcheck\":\"0.9.0\",\"nodejs\":\"18.11.0\",\"shfmt\":\"3.6.0\"}" :: String)

    it "returns empty json for invalid input" $ do
      (parseAsdf "invalid" & toJson) `shouldBe` ("{}" :: String)
