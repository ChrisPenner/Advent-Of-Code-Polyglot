calc :: String -> Integer 
calc = sum . map (\c -> if c == '(' then 1 else -1) 

findPosition :: String -> Int
findPosition s = (+1) $ length $ takeWhile (\n -> calc (take n s) >= 0) [1..] 

main :: IO()
main = getContents >>= print . findPosition . init
