import Data.Char
import Data.List

threeVowels :: String -> Bool
threeVowels s = countVowels s >= 3
  where countVowels ""     = 0
        countVowels (x:xs) = (if (x `elem` "aeiou") then 1 else 0) + countVowels xs

twice :: String -> Bool
twice s = (/=) [] $ filter (\l -> length l > 1) $ group s 

contains :: String -> [String] -> Bool
contains s l = or $ map (\s' -> s' `isInfixOf` s) l 

isNice :: String -> Int
isNice s 
  | threeVowels s && twice s && not (contains s ["ab", "cd", "pq", "xy"]) = 1
  | otherwise                                                             = 0

main :: IO()
main = getContents >>= print . sum . map isNice . lines 
