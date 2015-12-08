import Data.List.Split

data Box = Box Integer Integer Integer deriving (Show)

boxify :: [Integer] -> Box
boxify l@[a, b, c] = Box a b c

totalPaper :: [Box] -> Integer
totalPaper = sum . map wrap
  where wrap box@(Box a b c) = 2 * (sum $ areas box) + minimum (areas box)
        areas (Box a b c) = [a*b, a*c, b*c]

readInt :: String -> Int
readInt = read

main :: IO()
main = getContents >>= print . totalPaper . map (boxify . map read . splitOn "x") . lines
