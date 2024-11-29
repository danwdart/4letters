
{-# LANGUAGE OverloadedLists #-}
module Parser.Words.FrenchDigits (parse) where

import Data.List  qualified as L
import Data.Map   (Map)
import Data.Map   qualified as Map
import Data.Maybe
import Text.Read

charToInteger ∷ Char → Maybe Integer
charToInteger = readMaybe . L.singleton

wordMap ∷ Map Integer String
wordMap = [
    (0, "zero"),
    (1, "un"),
    (2, "deux"),
    (3, "trois"),
    (4, "quatre"),
    (5, "cinq"),
    (6, "six"),
    (7, "sept"),
    (8, "huit"),
    (9, "neuf")]

parse ∷ Integer → Integer
parse = toInteger . sum . fmap length . mapMaybe (wordMap Map.!?) . mapMaybe charToInteger . show
