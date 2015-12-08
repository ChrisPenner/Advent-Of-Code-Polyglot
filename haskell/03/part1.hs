import Data.List
import Data.Set as Set

data Point = Point Int Int deriving (Show, Eq, Ord)

move :: Point -> Char -> Point 
move p@(Point x y) '^' = Point x (y+1)
move p@(Point x y) 'v' = Point x (y-1)
move p@(Point x y) '<' = Point (x-1) y
move p@(Point x y) '>' = Point (x+1) y

houses :: Point -> Set Point -> String -> Set Point
houses curr visited moves
  | length moves == 0 = Set.insert curr visited 
  | otherwise         = houses (move curr $ head moves) (Set.insert curr visited) (tail moves) 

main :: IO()
main = getContents >>= print . Set.size . houses (Point 0 0) (Set.empty) . init 
