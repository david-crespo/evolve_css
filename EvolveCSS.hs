import Text.Parsec
import Text.Parsec.String

rule :: Parser Rule
rule = do
    p <- many1 letter
    char ':'
    spaces

    v <- many1 letter
    char ';'

    return $ Rule p v