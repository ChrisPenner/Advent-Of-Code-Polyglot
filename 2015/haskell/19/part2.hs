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

--
-- Part 2
--
-- Compute substitutions *backwards*, starting at the medicine molecule
-- towards the starting "e"lectron; using the biggest possible
-- substitution. Count the number of steps (== recursive calls)
-- along the way.

greedyEatString :: [Replacement] -> String -> Int
greedyEatString _ "e" = 0
greedyEatString repls s = 1 + greedyEatString repls shortenedStr
	where
		sortedRepls = reverse $ sortOn (length . snd) repls
		repl = head $ filter ((> 0) . length . substringIndices s . snd) sortedRepls
		shortenedStr = replaceAt s (fst repl) (length $ snd repl) startIdx
		startIdx = head $ substringIndices s $ snd repl

main = do
	cont <- readFile "input.txt"
	let (repls, medicine) = parseInput cont
	print $ greedyEatString repls medicine
