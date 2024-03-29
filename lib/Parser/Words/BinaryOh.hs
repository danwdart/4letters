{-# LANGUAGE OverloadedLists #-}
module Parser.Words.BinaryOh (parse) where

import Data.Digits
import Data.Map    (Map)
import Data.Map    qualified as Map
import Data.Maybe  (mapMaybe)

wordMap ∷ Map Integer String
wordMap = [
    (0, "oh"),
    (1, "one")
    ]

parse ∷ Integer → Integer
parse = toInteger . sum . fmap length . mapMaybe (wordMap Map.!?) . digits 2
