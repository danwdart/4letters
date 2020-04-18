module Main where

import Control.Monad.Identity
import Control.Monad.State
import Control.Monad.Writer
import Data.Function
import Data.List.Extra
import qualified Parser.Words.Binary as Binary
import qualified Parser.Words.EnglishDigits as EnDig
import qualified Parser.Words.FrenchDigits as FrDig

takeWhileNotRepeating :: [Integer] -> [Integer]
takeWhileNotRepeating = flip execState [] . takeWhileNotRepeating'

-- state
takeWhileNotRepeating' :: [Integer] -> State [Integer] [Integer]
takeWhileNotRepeating' [] = return []
takeWhileNotRepeating' (x:xs) = do
    g <- get
    if x `elem` g
    then return []
    else do
        modify (++ [x])
        takeWhileNotRepeating' xs

iter :: (Integer -> Integer) -> Integer -> [Integer]
iter fn x = takeWhileNotRepeating $ iterate fn x

biggest :: (Integer -> Integer) -> [(Integer, Int, [Integer])]
biggest fn = nubOrdOn (\(a, b, c) -> b) $ map (\x -> (x, length $ iter fn x, iter fn x)) [1..100000]

main :: IO ()
main = print $ biggest EnDig.parse