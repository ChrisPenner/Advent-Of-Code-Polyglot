import Data.List
import Data.Char

currPassword :: String
currPassword = getNextPassword "hxbxwxba" 

inc :: String -> String
inc s = reverse $ addOne (reverse s) True
  where addOne ""       _      = ""
        addOne s        False  = s
        addOne ('z':s') True   = 'a':addOne s' True
        addOne (c:s')   True   = (chr $ 1 + ord c):addOne s' False

isValid :: String -> Bool 
isValid s = incStraight s && letterCheck s && pairsCheck s
  where incStraight s = any (\(a,b,c) -> 1 + ord a == ord b && 1 + ord b == ord c) $ zip3 s (tail s) (tail $ tail s)
        letterCheck s = all (flip notElem s) "iol"
        pairsCheck    = (>1) . length . filter ((==2) . length) . nub . group  

getNextPassword :: String -> String
getNextPassword = head . dropWhile (not . isValid) . iterate (inc) . inc 

main :: IO ()
main = print $ getNextPassword currPassword
