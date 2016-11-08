import Data.Char
import Data.List

letters :: [String]
letters = map (\c -> c:"") ['a'..'z']

letterPairs :: [String]
letterPairs = [ a:b:"" | a <- ['a'..'z'], b <- ['a'..'z'] ]

substrIndices :: String -> String -> [Int] 
substrIndices hay needle = 
  map snd . filter (\(suf, idx) -> needle `isPrefixOf` suf) $ zip (tails hay) [1..]

diffs :: [Int] -> [Int]
diffs xs = map (\(a,b) -> b - a) $ zip xs (tail xs)

isNice :: String -> Bool
isNice s = pairs && singles
  where pairs   = any (\l -> l /= [] && last l - head l > 1) $ map (substrIndices s) letterPairs 
        singles = any (\l -> any (==2) l) $ map (diffs . substrIndices s) letters

fromBool :: Bool -> Int
fromBool b = if b then 1 else 0 

main :: IO()
main = getContents >>= print . sum . map (fromBool . isNice) . lines 
