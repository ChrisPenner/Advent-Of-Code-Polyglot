import Data.List

parseInput = map (read :: String -> Int) . lines
powersetSums = map (\s -> (s, sum s)) . subsequences
powersetSumsEqualing s n = map fst $ filter ((== n) . snd) $ powersetSums s

main = do
	cont <- readFile "input.txt"
	let containers = parseInput cont
	let subsets = powersetSumsEqualing containers 150
	print $ length subsets
