import Data.List as List
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

each :: Int -> [a] -> [a]
each n = List.map snd . List.filter (\(x,y) -> (mod x n) == 0) . zip [0..]

main :: IO()
main = do
  
  contents <- getContents 
  
  let santaMoves = each 2 (init contents)
  let roboMoves  = each 2 (tail $ init contents)
  
  let santaHouses = houses (Point 0 0) (Set.empty) santaMoves 
  let roboHouses  = houses (Point 0 0) (Set.empty) roboMoves 

  print $ Set.size $ Set.union santaHouses roboHouses
