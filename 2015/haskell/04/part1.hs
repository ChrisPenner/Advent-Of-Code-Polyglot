import Data.List as List
import Data.Digest.Pure.MD5
import Data.ByteString.Lazy.Char8 as BS

phrase :: String
phrase = "ckczppom"

solve :: Integer 
solve = List.head $ Prelude.dropWhile (\n -> countZeros phrase n /= 5) [1..]
  where
    hash s n = show . md5 . pack $ (s ++ show n)
    countZeros s n 
      | List.head (hash s n) /= '0' = 0
      | otherwise                   = List.length . List.head . List.group $ hash s n 

main :: IO()
main = print solve
