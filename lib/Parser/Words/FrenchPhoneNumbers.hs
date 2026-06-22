
{-# LANGUAGE OverloadedLists #-}
module Parser.Words.FrenchDigits (parse) where

import Data.List  qualified as L
import Data.Map   (Map)
import Data.Map   qualified as Map
import Data.Maybe
import Text.Read

charToInteger ∷ Char → Maybe Integer
charToInteger = readMaybe . L.singleton

wordMap ∷ Map Integer String
wordMap = [
    (0, "zero zero"),
    (1, "zero un"),
    (2, "zero deux"),
    (3, "zero trois"),
    (4, "zero quatre"),
    (5, "zero cinq"),
    (6, "zero six"),
    (7, "zero sept"),
    (8, "zero huit"),
    (9, "zero neuf"),
    (10, "dix"),
    (11, "onze"),
    (12, "douze"),
    (13, "treize"),
    (14, "quatorze"),
    (15, "quinze"),
    (16, "seize"),
    (17, "dix-sept"),
    (18, "dix-huit"),
    (19, "dix-neuf")
    ] <> (M.fromList . L.concat $ (\(t, tw) -> [(10 * t, tw)] <> fmap (\(u, uw) -> (10 * t + u, tw <> "-" <> uw)) [
        (1, "et-un"),
        (2, "deux"),
        (3, "trois"),
        (4, "quatre"),
        (5, "cinq"),
        (6, "six"),
        (7, "sept"),
        (8, "huit"),
        (9, "neuf")
    ]) [
        (2, "vingt"),
        (3, "trente"),
        (4, "quarante"),
        (5, "cinqante"),
        (6, "soixante")
    ]) <> [
    (70, "soixante-dix"),
    (71, "soixante-onze"),
    (72, "soixante-douze"),
    (73, "soixante-treize"),
    (74, "soixante-quatorze"),
    (75, "soixante-quinze"),
    (76, "soixante-seize"),
    (77, "soixante-dix-sept"),
    (78, "soixante-dix-huit"),
    (79, "soixante-dix-neuf "),
    (80, "quatre-vingts"),
    (81, "quatre-vingt-un"),
    (82, "quatre-vingt-deux"),
    (83, "quatre-vingt-trois"),
    (84, "quatre-vingt-quatre"),
    (85, "quatre-vingt-cinq"),
    (86, "quatre-vingt-six"),
    (87, "quatre-vingt-sept"),
    (88, "quatre-vingt-huit"),
    (89, "quatre-vingt-neuf"),
    (90, "quatre-vingt-dix"),
    (91, "quatre-vingt-onze"),
    (92, "quatre-vingt-douze"),
    (93, "quatre-vingt-treize"),
    (94, "quatre-vingt-quatorze"),
    (95, "quatre-vingt-quinze"),
    (96, "quatre-vingt-seize"),
    (97, "quatre-vingt-dix-sept"),
    (98, "quatre-vingt-dix-huit"),
    (99, "quatre-vingt-dix-neuf")
    ]

parse ∷ Integer → Integer
parse = toInteger . sum . fmap length . mapMaybe (wordMap Map.!?) . mapMaybe charToInteger . show
