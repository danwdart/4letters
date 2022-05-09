{-# LANGUAGE OverloadedLists #-}
module Parser.Words.Binary (parse) where

import           Data.Digits
import           Data.Map    (Map)
import qualified Data.Map    as Map
import           Data.Maybe  (mapMaybe)

wordMap ∷ Map Integer String
wordMap = [
    (0, "zero"),
    (1, "one")
    ]

parse ∷ Integer → Integer
parse = toInteger . sum . fmap length . mapMaybe (wordMap Map.!?) . digits 2
