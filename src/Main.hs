module Main where

import Data.Function
import Data.List.Extra
import qualified Parser.Words.English as En
import qualified Parser.Words.French as Fr

main :: IO ()
main = print $ nubOn snd $ map (\x -> (x, En.parse x)) [1..100000]