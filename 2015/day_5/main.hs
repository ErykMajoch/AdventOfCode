import qualified Data.Text    as Text
import qualified Data.Text.IO as Text
import Text.Printf

-- Part One
countVowels :: String -> Int
countVowels str = foldr (+) 0 (map isVowel str)
    where
      isVowel c
        | elem c "aeiou" = 1
        | otherwise      = 0

doubleLetters :: String -> Char -> Bool
doubleLetters [] _ = False
doubleLetters str prev
  | current == prev = True
  | otherwise       = doubleLetters rest current
  where
    current = head str
    rest = tail str

bannedCombos :: String -> String -> Bool
bannedCombos [] _ = False
bannedCombos str prev
  | elem sub ["ab", "cd", "pq", "xy"] = True
  | otherwise   = bannedCombos (tail str) ([head str])
  where
    sub = prev ++ ([head str])

part_one :: [String] -> Int
part_one [] = 0
part_one str
  | nice      = 1 + part_one (tail str)
  | otherwise = part_one (tail str)
  where
    nice = (a >= 3) && b && not c
      where
        a = countVowels (head str)
        b = doubleLetters (head str) '.'
        c = bannedCombos (head str) ""
  
-- Part Two
substring :: Int -> Int -> String -> String
substring start len str
  | len == 1   = [head str]
  | start == 0 = ([head str]) ++ substring start (len - 1) (tail str)
  | otherwise  = substring (start - 1) len (tail str)

containsPair :: String -> Int -> Bool
containsPair str index
  | index == (Prelude.length str) - 2    = False
  | (Prelude.length str) - (Text.length possible) >= 4 = True
  | otherwise = containsPair str (index + 1)
  where
    possible = Text.replace (Text.pack (substring index 2 str)) (Text.pack "") (Text.pack str)

sandwichedLetter :: String -> Bool
sandwichedLetter str = doubleLetters first '.' || doubleLetters second '.'
  where
    first = map (\n -> fst n) (filter (\n -> (snd n) `mod` 2 == 0) (zip str [1..Prelude.length str])) 
    second = map (\n -> fst n) (filter (\n -> (snd n) `mod` 2 == 1) (zip str [1..Prelude.length str]))

part_two :: [String] -> Int
part_two [] = 0
part_two str
  | nice      = 1 + part_two (tail str)
  | otherwise = part_two (tail str)
  where
    nice = containsPair (head str) 0 && sandwichedLetter (head str)

-- Main
main = do
  file <- readFile "input.txt"
  let p1_result = part_one (lines (file))
  let p2_result = part_two (lines (file))
  printf "Part one: %d\n" p1_result
  printf "Part two: %d\n" p2_result

