import Data.List.Split (splitOn)

file :: FilePath
file = "sample.txt"

parse :: String -> [Int]
parse = map (\x -> read x :: Int) . splitOn ","

countZeros :: [Int] -> Int
countZeros = foldl (\acc n -> if n == 0 then acc+1 else acc) 0

appendEigth :: Int -> [Int] -> [Int]
appendEigth 0 l = l
appendEigth n l = 8:appendEigth (n-1) l

passDay :: [Int] -> [Int]
passDay l = appendEigth (countZeros l) $ map (\x -> if x > 0 then x - 1 else 6) l

passNDays :: Int -> [Int] -> [Int]
passNDays 0 l = l
passNDays n l = passNDays (n-1) $ passDay l

main = do
    contents <- readFile file
    print $ length $ passNDays 256 $ parse contents