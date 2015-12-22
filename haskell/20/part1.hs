import Data.List
import Math.NumberTheory.Factor
import Math.Combinat

-- https://programmers.stackexchange.com/q/264064#305595
sumDivisorsTimes10 =
	(10 *) . product . map (sum . (scanl1 (*)) . (1 :)) . group . pfactors

-- 34000000 was my puzzle input
printSolution fn =
	print $ head $ filter ((>= 34000000) . snd) $ map (\n -> (n, fn n)) [1..]

main = printSolution sumDivisorsTimes10
