import Text.Printf

splitContinuous :: String -> [String]
splitContinuous [] = []
splitContinuous (x:xs) = (x : takeWhile (== x) xs) : splitContinuous (dropWhile (== x) xs)

lengthAndChar :: [String] -> [(String, Char)]
lengthAndChar strings = map (\s -> (show $ length s, head s)) strings

look_and_say :: String -> String
look_and_say [] = []
look_and_say input = concatMap (\(count, char) -> count ++ [char]) processed
  where
    processed = lengthAndChar $ splitContinuous input

day_ten :: String -> Int -> String
day_ten [] _ = []
day_ten input n = apply_n_times n look_and_say input
  where
    apply_n_times n f x 
      | n == 0    = x
      | otherwise = apply_n_times (n - 1) f (f x)

main = do
  printf "Part one: %d\n" (length $ day_ten "1321131112" 40)
  printf "Part two: %d\n" (length $ day_ten "1321131112" 50)

