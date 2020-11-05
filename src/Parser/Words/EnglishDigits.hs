{-# LANGUAGE UnicodeSyntax #-}
module Parser.Words.EnglishDigits (parse) where

import qualified Data.Map   as Map
import           Data.Maybe
import           Text.Read

charToInteger ∷ Char → Maybe Integer
charToInteger = readMaybe . return

wordMap ∷ Map.Map Integer String
wordMap = Map.fromList [
    (0, "zero"),
    (1, "one"),
    (2, "two"),
    (3, "three"),
    (4, "four"),
    (5, "five"),
    (6, "six"),
    (7, "seven"),
    (8, "eight"),
    (9, "nine")]

parse ∷ Integer → Integer
parse = toInteger . sum . fmap length . mapMaybe (wordMap Map.!?) . mapMaybe charToInteger . show
