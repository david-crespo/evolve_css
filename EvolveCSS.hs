import Control.Applicative hiding ((<|>))
import Text.Parsec
import Text.Parsec.String

import Stylesheet

paddedChar c = char c <* spaces

rule :: Parser Rule
rule = do
  p <- many1 (oneOf "-" <|> letter) <* paddedChar ':'
  v <- many1 (noneOf ";") <* paddedChar ';'

  return $ Rule p v

selector :: Parser String
selector = many1 (oneOf ".#-_*>" <|> alphaNum) <* spaces

ruleset :: Parser Ruleset
ruleset = do
    s <- selector `sepBy1` spaces
    r <- paddedChar '{' *> many1 rule <* paddedChar '}'

    return $ Ruleset (unwords s) r

ruleToStr :: Rule -> String
ruleToStr (Rule p v) = p ++ ": " ++ v ++ ";\n"

rulesetToStr :: Ruleset -> String
rulesetToStr (Ruleset s rs) = s ++ " {\n" ++ (concatMap ruleToStr rs) ++ "}\n\n"

stylesheetToStr :: Stylesheet -> String
stylesheetToStr = concatMap rulesetToStr
