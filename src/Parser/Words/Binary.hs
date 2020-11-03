{-# LANGUAGE UnicodeSyntax #-}
module Parser.Words.Binary (parse) where

import           Data.Digits
import qualified Data.Map    as Map
import           Data.Maybe

-- charToInteger ∷ Char → Maybe Integer
-- charToInteger = readMaybe . return

wordMap ∷ Map.Map Integer String
wordMap = Map.fromList [
    (0, "zero"),
    (1, "one")
    ]

parse ∷ Integer → Integer
parse = toInteger . sum . map length . mapMaybe ((Map.!?) wordMap) . digits 2
