import Data.List.Split
import Data.List
import qualified Data.Map as M (Map, fromList, toList, lookup)
import qualified Data.Set as S (Set, fromList, toList)

-- Map keys: (person gaining/loosing happiness, person who sits next to him/her)
type HappinessValues = M.Map (String, String) Int

-- this ain't pretty
parseInput :: String -> HappinessValues
parseInput = M.fromList . map parseLine . lines
	where
		parseLine = parseLine' . reverse . drop 1 . reverse
		parseLine' :: String -> ((String, String), Int)
		parseLine' l = ((name1, name2), units)
			where
				p1 = splitOn " would " l -- parts, #1
				name1 = p1 !! 0
				r1 = p1 !! 1
				p2 = splitOn " happiness units by sitting next to " r1
				name2 = p2 !! 1
				r2 = p2 !! 0
				p3 = splitOn " " r2
				unsignedUnits = (read $ p3 !! 1 :: Int)
				units = if p3 !! 0 == "gain" then
					unsignedUnits
				else
					-unsignedUnits

-- Calculate total happiness of a particular ordering
happinessOfPermutation :: HappinessValues -> [String] -> Int
happinessOfPermutation vals perm = sum $ map happinessOfPerson perm
	where
		happinessOfPerson :: String -> Int
		happinessOfPerson name = left + right
			where
				nilZero = maybe 0 id
				neighborVal idx = nilZero $ M.lookup (name, neighbor idx name) vals
				left = neighborVal (-1)
				right = neighborVal 1
				neighbor :: Int -> String -> String -- the `offset`-th neighbor of `name`
				neighbor offset name = perm !! ((idx + offset) `mod` length perm)
					where idx = nilZero $ elemIndex name perm

maximumHappiness :: HappinessValues -> [String] -> Int
maximumHappiness vals names =
	maximum $ map (happinessOfPermutation vals) $ permutations names

allNames :: HappinessValues -> [String]
allNames = S.toList . S.fromList . map (fst . fst) . M.toList

printHappinessForFile :: String -> IO ()
printHappinessForFile fname = do
	cont <- readFile fname
	let vals = parseInput cont
	let names = allNames vals
	print $ maximumHappiness vals names

main = printHappinessForFile "input2.txt"
