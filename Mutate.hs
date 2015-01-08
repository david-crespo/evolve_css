module Mutate where

import Stylesheet

-- combine two lists by concatenating the first halves of the first with
-- the  second half of the second
combine :: [a] -> [a] -> [a]
combine s1 [] = s1
combine [] s2 = s2
combine s1 s2 = firstHalf s1 ++ secondHalf s2 where
    firstHalf s = take (halfLength s) s
    secondHalf s = drop (halfLength s) s
