module Parser.Words.English (parse) where

import qualified Data.Map as Map
import Data.Maybe
import Text.Read

charToInt :: Char -> Maybe Int
charToInt = readMaybe . return

wordMap :: Map.Map Int String
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

parse :: Integer -> Int
parse = sum . map length . mapMaybe ((Map.!?) wordMap) . mapMaybe charToInt . show