module Stylesheet where


data SimpleSize = Pixel Int | Percentage Int deriving (Show)
data CompositeSize = CompositeSize SimpleSize SimpleSize SimpleSize SimpleSize deriving (Show)

type Selector = String
type PropName = String

data PropValue = SimpleSize | CompositeSize

data Rule = Rule Selector PropName PropValue deriving (Show)
type Stylesheet = [Rule]
