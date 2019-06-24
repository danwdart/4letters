module Parser.Words.French (parse) where

import qualified Data.Map as Map
import Data.Maybe
import Text.Read

charToInt :: Char -> Maybe Int
charToInt = readMaybe . return

wordMap :: Map.Map Int String
wordMap = Map.fromList [
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

parse :: Integer -> Int
parse = sum . map length . mapMaybe ((Map.!?) wordMap) . mapMaybe charToInt . show