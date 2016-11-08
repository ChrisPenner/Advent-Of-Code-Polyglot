getDiff :: String -> Int
getDiff "" = 2
getDiff ('\\':c:s)
  | c == '\\' = (+1) $ getDiff s
  | c == '\"' = (+1) $ getDiff s 
  | c == 'x'  = (+3) . getDiff $ drop 2 s 
getDiff (c:s) = getDiff s

main :: IO()
main = getContents >>= print . sum . map getDiff . lines 

