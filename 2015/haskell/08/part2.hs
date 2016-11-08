main :: IO()
main = getContents >>= print . sum . map (\l -> (length $ show l) - (length l)) . lines 
