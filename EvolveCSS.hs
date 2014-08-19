import Text.Parsec
import Text.Parsec.String

type Selector = String
data Rule = Rule String String deriving Show
data Ruleset = Ruleset Selector [Rule] deriving Show

rule :: Parser Rule
rule = do
    p <- many1 letter
    char ':'
    spaces

    v <- many1 letter
    char ';'

    return $ Rule p v