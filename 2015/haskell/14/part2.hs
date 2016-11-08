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

raceStep :: DeerState -> DeerState
raceStep state = DeerState {
	deer = map updateDeer allDeer,
	step = step state + 1
}
	where
		allDeer = deer state
		leadingDeers = map name $ filter ((== maxDistance) . distance) allDeer
		distances = map distance allDeer
		maxDistance = maximum distances
		-- Do the same thing as in raceReindeer,
		-- but only one second at a time, and register
		-- the best reindeer (those who got the furthest).
		distance = raceReindeer $ step state
		-- This function either awards a point to the specified deer
		-- if its distance is among the highest, otherwise
		-- it assigns it its original score.
		updateDeer d =
			if elem (name d) leadingDeers then
				d { points = points d + 1 }
			else
				d

-- Runs all steps of the simulation and returns the last step
raceReindeerStep :: Int -> [Reindeer] -> DeerState
raceReindeerStep time deer =
	-- time + 1 is necessary because we start from step 1
	-- (as opposed to step 0), and that's needed in turn
	-- because we want to evaluate each step after one second
	-- has already passed (so the 0th elem of the list really
	-- reflects the state after 1 second).
	last $ takeWhile ((<= time + 1) . step) $ (iterate raceStep s0)
		where
			s0 = DeerState { deer = deer, step = 1 }

main = do
	deerList <- parseInput "input.txt"
	let steps = 2503
	let finalState = raceReindeerStep steps deerList
	print $ maximum $ map points $ deer finalState
