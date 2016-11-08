import Data.List.Split

data Box = Box Integer Integer Integer deriving (Show)

boxify :: [Integer] -> Box
boxify l@[a, b, c] = Box a b c

totalRibbon :: [Box] -> Integer
totalRibbon = sum . map wrap
  where wrap box@(Box a b c)   = minimum (perimeters box) + volume box
        perimeters (Box a b c) = [2*(a+b), 2*(a+c), 2*(b+c)]
        volume (Box a b c)     = a*b*c

readInt :: String -> Int
readInt = read

main :: IO()
main = getContents >>= print . totalRibbon . map (boxify . map read . splitOn "x") . lines
