import Control.Applicative hiding ((<|>))
import Text.Parsec
import Text.Parsec.String

type Selector = String
data Rule = Rule String String deriving Show
data Ruleset = Ruleset Selector [Rule] deriving Show

paddedChar c = char c <* spaces

rule :: Parser Rule
rule = do
  p <- many1 letter <* paddedChar ':'
  v <- many1 (noneOf ";") <* paddedChar ';'

  return $ Rule p v

ruleset :: Parser Ruleset
ruleset = do
    s <- many1 (noneOf "{")
    r <- paddedChar '{' *> many1 rule <* paddedChar '}'

    return $ Ruleset s r