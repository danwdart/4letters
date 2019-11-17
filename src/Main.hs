module Main where

import Data.Function
import Data.List.Extra
import qualified Parser.Words.English as En
import qualified Parser.Words.French as Fr

data RepetitionResult = RepetitionResult {
    allUntilRepeat :: [Integer],
    repeatedResult :: [Integer]
}

detectRepetition :: [Integer] -> RepetitionResult
detectRepetition ns = RepetitionResult [1,2,3] [3]

-- state
takeWhileNotRepeating :: [Integer] -> [Integer]
takeWhileNotRepeating [] = []
takeWhileNotRepeating x:xs = 


main :: IO ()
main = print $ nubOn snd $ map (\x -> (x, En.parse x)) [1..100000]