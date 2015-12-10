import Data.List
import Data.Maybe

import qualified Data.Map as M

type Node = String
type Edge = (Node, Node)

getEdges :: [[String]] -> M.Map Edge Int
getEdges lines = M.fromList [((l !! 0, l !! 2), read $ l !! 4) | l <- lines]

getNodes :: [[String]] -> [Node]
getNodes l = nub $ (map (!! 2) l) ++ (map head l)

getTotalDist :: [Node] -> M.Map Edge Int -> Int
getTotalDist v e = sum . map (\l -> fromJust $ getDist l) $ zip v (tail v)
  where getDist (u,v) 
          | M.member (u,v) e = M.lookup (u,v) e
          | otherwise        = M.lookup (v,u) e

main :: IO()
main = do 
  contents <- getContents
  let edges = getEdges . map words $ lines contents
  let nodes = getNodes . map words $ lines contents
  print . maximum . map (\n -> getTotalDist n edges) $ permutations nodes  
