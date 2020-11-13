{-# LANGUAGE UnicodeSyntax #-}
module Main where

import           Data.List.Extra
-- import qualified Parser.Words.EnglishDigits as EnDig
-- import qualified Parser.Words.FrenchDigits as FrDig
-- import qualified Parser.Words.Binary as BinDig
import qualified Parser.Words.BinaryWithSpaces as BinDigSpaces

takeUntilRepeat ∷ Eq a ⇒ [a] → [a]
takeUntilRepeat [] = []
takeUntilRepeat (x:y:_) | x == y = [x]
takeUntilRepeat xs = ((<>) <$> fmap fst <*> pure . snd . last) .
    takeWhile (uncurry (/=)) $
    zip xs (tail xs)

iter ∷ (Integer → Integer) → Integer → [Integer]
iter fn x = takeUntilRepeat $ iterate fn x

biggest ∷ (Integer → Integer) → [(Integer, Int, [Integer])]
biggest fn = nubOrdOn (\(_, b, _) -> b) $ fmap (\x -> (x, length $ iter fn x, iter fn x)) [1..100000]

alls ∷ (Integer → Integer) → [(Integer, Int, [Integer])]
alls fn = fmap (\x -> (x, length $ iter fn x, iter fn x)) [1..10000000]


main ∷ IO ()
main = do
    --putStrLn "English"
    --print $ biggest EnDig.parse
    --putStrLn "Binary"
    --print $ biggest BinDig.parse
    putStrLn "Binary with spaces, except 21s"
    mapM_ print . filter ((/= 21) . snd) . fmap (\(a, _, c) -> (a, last c)) $ alls BinDigSpaces.parse
