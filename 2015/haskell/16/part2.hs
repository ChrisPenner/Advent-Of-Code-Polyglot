import Data.List
import Data.List.Split
import Data.Generics


type Aunt = [(String, Int)]

-- Parse the properties of one Aunt Sue.
-- this ain't pretty, but I can't be bothered to make it pretty.
parseLine :: String -> Aunt
parseLine =
	map (parsePair . splitOn ":")
	. splitOn ", "
	. intercalate ":"
	. drop 1
	. splitOn ": "
	where parsePair (name:valstr:_) = (name, read valstr :: Int)

parseInput = map parseLine . lines

sue :: Aunt
sue = [
	("children", 3),
	("cats", 7),
	("samoyeds", 2),
	("pomeranians", 3),
	("akitas", 0),
	("vizslas", 0),
	("goldfish", 5),
	("trees", 3),
	("cars", 2),
	("perfumes", 1)
	]

-- filter Aunts Sue who may potentially have the specified properties.
-- (i.e. they either explicitly do or we don't remember.)
-- 'useExact' specifies whether we always search for exact values (True)
-- or assume ranges for the specified property names (False)
filterAunts :: [Aunt] -> Aunt -> [Aunt]
filterAunts aunts target = filter candidate aunts
	where candidate aunt =
		and $ map checkProperty target
		where checkProperty (name, quant) =
			maybe True (compFn quant) $ lookup name aunt
			where compFn =
				case name of
					"cats"        -> (<)
					"trees"       -> (<)
					"pomeranians" -> (>)
					"goldfish"    -> (>)
					_             -> (==)

-- get indices of all possible candidates - hopefully exactly one.
-- +1 is there because the problem assumes 1-based indexing.
candidateIndices sues cands =
	map (+ 1) $ concatMap (flip elemIndices $ sues) cands

main = do
	cont <- readFile "input.txt"
	let sues = parseInput cont
	print $ candidateIndices sues $ filterAunts sues sue

