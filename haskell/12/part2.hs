import Text.Parsec
import Control.Applicative ((<*), (*>), (<$>))

data Json = JInt Int      | JObject [(String, Json)] | 
            JArray [Json] | JString String  
            deriving (Show, Eq)

--Minimal JSON parser --> can't cope with spaces, newlines or most escape sequences

jCollParser :: Char -> Char -> Parsec String st ret -> Parsec String st [ret]
jCollParser sep1 sep2 btwn = between (char sep1) (char sep2) $ sepBy btwn (char ',')

stringParser = between (char '"') (char '"') $ many sChar
  where sChar = (char '\\' *> oneOf escapeChars) <|> noneOf escapeChars
        escapeChars = "\\\""

jStringParser = JString <$> stringParser

jIntParser  = ((JInt . read) .) . (:) <$> option '0' (char '-') <*> many1 digit

jObjectParser = JObject <$> jCollParser '{' '}' propParser
  where propParser = (,) <$> stringParser <* char ':' <*> jsonParser

jArrayParser = JArray <$> jCollParser '[' ']' jsonParser


jsonParser = jIntParser <|> jObjectParser <|> jArrayParser <|> jStringParser

parseJson = parse jsonParser "(unknown)"


sumOfJson excl (JInt i) = i
sumOfJson excl (JString _) = 0
sumOfJson excl (JObject props)  
  | excl props = 0
  | otherwise  = sum $ fmap (sumOfJson excl . snd) props
sumOfJson excl (JArray arr) = sum $ fmap (sumOfJson excl) arr


main = interact (show . (sumOfJson ((JString "red" `elem`) . map snd) `fmap`) . parseJson)
