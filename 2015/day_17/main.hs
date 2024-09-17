import Data.List (sort)
import qualified Data.Text    as Text
import qualified Data.Text.IO as Text
import Text.Printf

containers :: [Int]
containers = [43, 3, 4, 10, 21, 44, 4, 6, 47, 41, 34, 17, 17, 44, 36, 31, 46, 9, 27, 38]

subsequencesOfSize :: Int -> [a] -> [[a]]
subsequencesOfSize n xs = let l = length xs
                          in if n > l then [] else subsequencesBySize xs !! (l-n)
 where
   subsequencesBySize [] = [[[]]]
   subsequencesBySize (x:xs) = let next = subsequencesBySize xs
                             in zipWith (++) ([]:next) (map (map (x:)) next ++ [[]])

minimumContainers :: Int -> Int -> Int -> [Int] -> Int
minimumContainers _ _ _ [] = 0
minimumContainers count sum target conts
  | currentSum >= target = count + 1
  | otherwise = minimumContainers (count + 1) currentSum target (tail conts)
    where
      currentSum = sum + (head conts)

partOne :: Int -> Int -> Int
partOne n count 
  | n == length containers = result
  | otherwise = partOne (n + 1) result
    where
      result = count + (length $ filter (\n -> sum n == 150) $ subsequencesOfSize n containers)

partTwo :: Int
partTwo = length $ filter (\n -> sum n == 150) $ subsequencesOfSize (minimumContainers 0 0 150 (reverse $ sort $ containers)) containers

main = do
 let part_one = partOne 0 0
 let part_two = partTwo
 printf "Part One: %d\n" part_one
 printf "Part Two: %d\n" part_two 

