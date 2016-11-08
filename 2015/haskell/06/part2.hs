import Data.List
import Data.List.Split

data Coord = Coord Int Int deriving (Show)
data Query = Toggle (Coord, Coord) | On (Coord, Coord) | Off (Coord, Coord) deriving (Show)

coordFromList :: [Int] -> Coord
coordFromList (a:b:[]) = Coord a b

getRect :: [String] -> (Coord, Coord)
getRect line 
  | head line == "toggle" = (getCoord $ line !! 1, getCoord $ line !! 3)
  | otherwise             = (getCoord $ line !! 2, getCoord $ line !! 4)
  where getCoord = coordFromList . map (read) . splitOn "," 

getQuery :: [String] -> Query
getQuery line  
  | head line == "toggle" = Toggle $ getRect line
  | line !! 1 == "on"     = On     $ getRect line
  | otherwise             = Off    $ getRect line 

isInside :: Coord -> Coord -> Coord -> Bool
isInside (Coord r c) (Coord r1 c1) (Coord r2 c2) = r >= r1 && r <= r2 && c >= c1 && c <= c2

getLight :: Int -> Coord -> [Query] -> Int
getLight val c [] = val 
getLight val c (Toggle (lo,hi):qs) 
  | isInside c lo hi = getLight (val+2) c qs
  | otherwise        = getLight val     c qs
getLight val c (On (lo,hi):qs)
  | isInside c lo hi = getLight (val+1) c qs
  | otherwise        = getLight val     c qs
getLight val c (Off (lo,hi):qs)
  | isInside c lo hi = getLight (max 0 (val-1)) c qs
  | otherwise        = getLight val             c qs

evaluate :: [Query] -> Int
evaluate qs = sum [getLight 0 (Coord r c) qs | r <- [0..999], c <- [0..999]]

main :: IO()
main = getContents >>= print . evaluate . map (getQuery . words) . lines 
