module Mutate where

import Stylesheet

-- combine two lists by concatenating the first halves of the first with
-- the  second half of the second
combine :: [a] -> [a] -> [a]
combine s1 [] = s1
combine [] s2 = s2
combine s1 s2 = firstHalf s1 ++ secondHalf s2 where
    halfLength s = (length s) `div` 2
    firstHalf s = take (halfLength s) s
    secondHalf s = drop (halfLength s) s


-- MUTATORS

addRule :: Stylesheet -> [Selector] -> Int -> Stylesheet
addRule s sels r = s ++ [newRule] where
    newSelector = eltForSeed sels r
    newRule = Rule newSelector "margin" (Pixel 10)


-- GENERATORS

generateSelector :: [Selector] -> Int -> Selector
generateSelector = eltForSeed

-- generateMargin :: Int -> Rule
-- generateMargin r = Rule "margin"

-- we will want to be able to generate more complex selectors, but this is a start


-- UTILITIES

-- select an element from a list based on a (large) integer
eltForSeed :: [a] -> Int -> a
eltForSeed xs r = xs !! rIdx where
    rIdx = r `mod` (length xs)
