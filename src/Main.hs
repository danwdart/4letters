{-# LANGUAGE UnicodeSyntax #-}
module Main where

import           Data.List.Extra                 (group, nubOrdOn, sort)
import qualified Parser.Words.EnglishDigits      as EnDig
-- import qualified Parser.Words.FrenchDigits as FrDig
import           Data.Bifunctor                  (Bifunctor (first))
import qualified Parser.Words.Binary             as BinDig
import qualified Parser.Words.BinaryOh           as BinDigOh
import qualified Parser.Words.BinaryOhWithSpaces as BinDigOhSpaces
import qualified Parser.Words.BinaryWithSpaces   as BinDigSpaces

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
    mapM_ print . freq . fmap snd . contract $ alls BinDig.parse
    putStrLn "Binary with spaces, except 21s"
    mapM_ print . filter ((/= 21) . snd) . contract $ alls BinDigSpaces.parse
    putStrLn "Binary (oh), proportions"
    mapM_ print . freq . fmap snd . contract $ alls BinDigOh.parse
    putStrLn "Binary (oh) with spaces, except 15s"
    mapM_ print . filter ((/= 15) . snd) . contract $ alls BinDigOhSpaces.parse
