import Data.List.Split
import Math.Combinat


data Ingredient = Ingredient {
	name       :: String,
	capacity   :: Int,
	durability :: Int,
	flavor     :: Int,
	texture    :: Int,
	calories   :: Int
} deriving (Show)

parseLine :: String -> Ingredient
parseLine line = Ingredient {
	name       = n,
	capacity   = namedProperty "capacity",
	durability = namedProperty "durability",
	flavor     = namedProperty "flavor",
	texture    = namedProperty "texture",
	calories   = namedProperty "calories"
}
	where
		sides = splitOn ": " line
		n = sides !! 0
		properties = sides !! 1
		plist = splitOn ", " properties
		pairlist = map parseProperty plist
		parseProperty s = (pname, pvalue)
			where
				sides = splitOn " " s
				pname = sides !! 0
				pvalue = read $ sides !! 1 :: Int
		namedProperty n = maybe 0 id $ lookup n pairlist

parseInput :: String -> [Ingredient]
parseInput = map parseLine . lines

--
-- Part 1
--
cookieScore :: [(Ingredient, Int)] -> Int
cookieScore cookie = product $ map propertyScore
	[capacity, durability, flavor, texture]
	where
		propertyScore :: (Ingredient -> Int) -> Int
		propertyScore accessor =
			max 0 $ sum $ map (\(ing, quant) -> accessor ing * quant) cookie

-- Part 2
-- The trick for re-using cookieScore is as follows:
-- since we are looking for the maximal score, and all scores
-- are non-negative, we can solve the problem by setting
-- the score of non-500-calorie cookies to 0.
fiveHundredCalorieCookieScore :: [(Ingredient, Int)] -> Int
fiveHundredCalorieCookieScore cookie =
	if cals == 500 then
		cookieScore cookie
	else
		0
	where
		cals = sum $ map (\(ing, quant) -> calories ing * quant) cookie


main = do
	cont <- readFile "input.txt"
	let ingrs = parseInput cont
	let ncomps = compositions (length ingrs) 100
	let cookies = map (zip ingrs) ncomps
	print $ maximum $ map fiveHundredCalorieCookieScore cookies
