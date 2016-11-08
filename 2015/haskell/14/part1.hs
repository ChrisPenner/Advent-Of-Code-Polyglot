import Data.List.Split


data Reindeer = Reindeer {
	name         :: String,
	speed        :: Int,
	timeOfFlight :: Int,
	timeOfRest   :: Int,
	period       :: Int,     -- timeOfFlight + timeOfRest,
	points       :: Int      -- cumulated # of points the deer collected
} deriving (Show)

data DeerState = DeerState {
	deer :: [Reindeer],
	step :: Int -- timestep in seconds
} deriving (Show)

parseWithSeparators :: String -> [String] -> [String]
parseWithSeparators str [] = [str]
parseWithSeparators str (sep:rest) =
	(parts !! 0) : parseWithSeparators (parts !! 1) rest
	where
		parts = splitOn sep str

parseLine :: String -> Reindeer
parseLine line = Reindeer {
	name         = parts !! 0,
	speed        = ints !! 0,
	timeOfFlight = ints !! 1,
	timeOfRest   = ints !! 2,
	period       = ints !! 1 + ints !! 2,
	points       = 0
} where
	-- oh no, not again the Split-based parsing!
	parts = parseWithSeparators line [
		" can fly ",
		" km/s for ",
		" seconds, but then must rest for ",
		" seconds"
		]
	name = parts !! 0
	ints = map (read :: String -> Int) $ drop 1 parts

parseInput :: String -> IO [Reindeer]
parseInput fname = readFile fname >>= (return . map parseLine . lines)


-- returns the distance traveled
raceReindeer :: Int -> Reindeer -> Int
raceReindeer time d = (baseTime + extraTime) * speed d
	where
		periods = time `div` period d
		baseTime = periods * timeOfFlight d
		extraTime = min (timeOfFlight d) $ time `mod` period d

main = do
	deerList <- parseInput "input.txt"
	let steps = 2503
	let dists = map (raceReindeer steps) deerList
	print $ maximum dists
