import Data.List

getNext :: String -> String 
getNext s = concatMap (\g -> (show $ length g) ++ [head g]) $ group s

main :: IO ()
main = print . length $ iterate (getNext) "1321131112" !! 50
