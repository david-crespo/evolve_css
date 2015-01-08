module Stylesheet where

type Selector = String
data Rule = Rule String String deriving Show
data Ruleset = Ruleset Selector [Rule] deriving Show
type Stylesheet = [Ruleset]
