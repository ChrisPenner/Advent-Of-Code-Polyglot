calc :: String -> Integer 
calc = sum . map (\c -> if c == '(' then 1 else -1) 

main :: IO()
main = getContents >>= print . calc . init
