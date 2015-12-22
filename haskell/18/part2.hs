import qualified Data.Map as M


-- The array of lights: 2D Int -> Bool: On or Off
type Lights = M.Map (Int, Int) Bool

-- Lights "off the table" are considered to be turned off
lightAt :: (Int, Int) -> Lights -> Bool
lightAt idx m = maybe False id $ M.lookup idx m

parseInput :: String -> Lights
parseInput =
	M.fromList
	. concat
	. map (\(f, s) -> zip [(f, x) | x <- [0..99]]
	$ map (== '#') s)
	. zip [0..99]
	. lines

-- Part 1
nextGeneration :: Lights -> Lights
nextGeneration lights =
	M.fromList [((x, y), evolveLight (x, y)) | x <- [0..99], y <- [0..99]]
	where
		evolveLight idx@(x, y) =
			case (neighbors, lightAt idx lights) of
				(2, state) -> state
				(3, _)     -> True
				(_, _)     -> False
			where neighbors = length $ filter (== True)
				[lightAt (i, j) lights | i <- [x - 1..x + 1],
				                         j <- [y - 1..y + 1],
				                         not (i == x && j == y)]

-- Part 2
nextGenStuckCorners :: Lights -> Lights
nextGenStuckCorners =
	  M.insert (0,   0) True
	. M.insert (0,  99) True
	. M.insert (99,  0) True
	. M.insert (99, 99) True
	. nextGeneration

onAfter100Gens fn =
	length . filter ((== True) . snd) . M.toList . head . drop 100 . iterate fn

main = do
	cont <- readFile "input.txt"
	let initState = parseInput cont
	print $ onAfter100Gens nextGenStuckCorners $ initState
