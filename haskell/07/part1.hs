import Data.Bits
import Data.Char 
import Data.Maybe
import Data.Word

import Debug.Trace
 
import qualified Data.HashMap.Strict as Map

type Wire = String 
data Gate = Direct Wire | Not Wire | Or Wire Wire | And Wire Wire | LShift Wire Int | RShift Wire Int deriving (Show)

toGate :: [String] -> Gate
toGate l 
  | length l == 2      = Direct (head l)
  | length l == 3      = Not (l !! 1)
  | l !! 1 == "OR"     = Or (head l) (l !! 2)
  | l !! 1 == "AND"    = And (head l) (l !! 2)
  | l !! 1 == "LSHIFT" = LShift (head l) (read $ l !! 2)
  | otherwise          = RShift (head l) (read $ l !! 2)
 
fillGates :: [[String]] -> Map.HashMap Wire Gate
fillGates = Map.fromList . map (\l -> (last l, toGate $ init l)) 

inWire :: Wire -> Map.HashMap Wire Word16 -> Map.HashMap Wire Gate -> Map.HashMap Wire Word16
inWire w memo gates 
  | Map.member w memo = memo
  | otherwise         = solveGate w gates memo . fromJust $ Map.lookup w gates

solveGate :: Wire -> Map.HashMap Wire Gate -> Map.HashMap Wire Word16 -> Gate -> Map.HashMap Wire Word16
solveGate w gates memo (Direct n)    = Map.insert w a memo
  where memo' = if isDigit (head n) then memo else inWire n memo gates
        a     = if isDigit (head n) then read n else fromJust $ Map.lookup n memo'
solveGate w gates memo (Not w')      = Map.insert w (complement . fromJust $ Map.lookup w' memo') memo'
  where memo' = inWire w' memo gates
solveGate w gates memo (LShift w' n) = Map.insert w (shift (fromJust $ Map.lookup w' memo') n) memo'
  where memo' = inWire w' memo gates
solveGate w gates memo (RShift w' n) = Map.insert w (shift (fromJust $ Map.lookup w' memo') (-n)) memo'
  where memo' = inWire w' memo gates
solveGate w gates memo (Or w1 w2)    = Map.insert w ((.|.) (fromJust $ Map.lookup w1 memo'') (fromJust $ Map.lookup w2 memo'')) memo''
  where memo'  = inWire w1 memo gates
        memo'' = inWire w2 memo' gates
solveGate w gates memo (And w1 w2)   = Map.insert w ((.&.) a b) memo''
  where memo'  = if isDigit (head w1) then memo else inWire w1 memo gates
        memo'' = if isDigit (head w2) then memo' else inWire w2 memo' gates
        a      = if isDigit (head w1) then read w1 else fromJust $ Map.lookup w1 memo''
        b      = if isDigit (head w2) then read w2 else fromJust $ Map.lookup w2 memo''

main :: IO()
main = getContents >>= print . fromJust . Map.lookup "a" . inWire "a" Map.empty . fillGates . map words . lines
