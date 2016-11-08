import qualified Data.Set as S
import Data.List
import Data.List.Split


type Replacement = (String, String)

parseInput :: String -> ([Replacement], String)
parseInput str = (repls, medicine)
	where
		parts = splitOn "\n\n" str
		medicine = filter (/= '\n') $ parts !! 1
		repls = map parseLine $ lines $ parts !! 0
		parseLine line = (sides !! 0, sides !! 1)
			where
				sides = splitOn " => " line

replaceAt :: String -> String -> Int -> Int -> String
replaceAt str sub len idx = take idx str ++ sub ++ drop (idx + len) str

--
-- Part 1
--
substringIndices :: String -> String -> [Int]
substringIndices str subs = findIndices (isPrefixOf subs) $ tails str

possibleReplacements :: String -> Replacement -> [String]
possibleReplacements str (orig, subs) = map (replaceAt str subs $ length orig) indices
	where
		indices = substringIndices str orig

allReplacements :: String -> [Replacement] -> [String]
allReplacements str repls = concatMap (possibleReplacements str) repls

main = do
	cont <- readFile "input.txt"
	let (repls, medicine) = parseInput cont
	print $ length $ S.fromList $ allReplacements medicine repls
