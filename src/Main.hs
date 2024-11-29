{-# OPTIONS_GHC -Wno-x-partial #-}

module Main (main) where

import Data.List.Extra                 (group, nubOrdOn, sort)
import Parser.Words.EnglishDigits      qualified as EnDig
-- import Parser.Words.FrenchDigits qualified as FrDig
import Data.Bifunctor                  (Bifunctor (first))
import Data.Foldable
import Parser.Words.Binary             qualified as BinDig
import Parser.Words.BinaryOh           qualified as BinDigOh
import Parser.Words.BinaryOhWithSpaces qualified as BinDigOhSpaces
import Parser.Words.BinaryWithSpaces   qualified as BinDigSpaces

takeUntilRepeat ∷ Eq a ⇒ [a] → [a]
takeUntilRepeat [] = []
takeUntilRepeat (x:y:_) | x == y = [x]
takeUntilRepeat xs = ((<>) <$> fmap fst <*> pure . snd . last) .
    takeWhile (uncurry (/=)) $
    zip xs (tail xs)

iter ∷ (Integer → Integer) → Integer → [Integer]
iter fn x = takeUntilRepeat $ iterate fn x

biggest ∷ (Integer → Integer) → [(Integer, Int, [Integer])]
biggest fn = nubOrdOn (\(_, b, _) -> b) $ fmap (\x -> (x, length $ tail (iter fn x), tail (iter fn x))) [1..1000000]

alls ∷ (Integer → Integer) → [(Integer, Int, [Integer])]
alls fn = fmap (\x -> (x, length $ iter fn x, iter fn x)) [1..1000000]

contract ∷ Functor f ⇒ f (a, b1, [b2]) → f (a, b2)
contract = fmap (\(a, _, c) -> (a, last c))

freq ∷ Ord a ⇒ [a] → [(a, Int)]
freq = fmap (first head . (\x -> ([head x], length x))) . group . sort

main ∷ IO ()
main = do
    putStrLn "English"
    print $ biggest EnDig.parse
    -- putStrLn "French"
    -- print $ biggest FrDig.parse
    putStrLn "Binary, smallest digits with longest length"
    print $ biggest BinDig.parse
    putStrLn "Binary (oh), smallest digits with longest length"
    print $ biggest BinDigOh.parse
    putStrLn "Binary with spaces, smallest digits with longest length"
    print $ biggest BinDigSpaces.parse
    putStrLn "Binary (oh) with spaces, smallest digits with longest length"
    print $ biggest BinDigOhSpaces.parse
    putStrLn "Binary, proportions"
    traverse_ print . freq . fmap snd . contract $ alls BinDig.parse
    putStrLn "Binary with spaces, except 21s"
    traverse_ print . filter ((/= 21) . snd) . contract $ alls BinDigSpaces.parse
    putStrLn "Binary (oh), proportions"
    traverse_ print . freq . fmap snd . contract $ alls BinDigOh.parse
    putStrLn "Binary (oh) with spaces, except 15s"
    traverse_ print . filter ((/= 15) . snd) . contract $ alls BinDigOhSpaces.parse
