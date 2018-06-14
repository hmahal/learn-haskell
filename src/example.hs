-- Functions to be loaded into GHCi for testing testing Haskell features

-- Function without an exhaustive pattern matching
charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"

-- Function to implement our own version of head
head' :: [a] -> a
head' [] = error "Can't call head on an empty list."
head' (x:_) = x

-- Function that uses pattern matching to show the first two elements of a list
tell :: (Show a) => [a] -> String
tell [] = "Empty list"
tell (x:[]) = show x
tell (x:y:[]) = show x ++ " " ++ show y
tell (x:y:_) = show x ++ " " ++show y ++ " ..."

-- Function to get list length using pattern matching
length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

-- Function returning sum of list using pattern matching
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

--Function showing the usage of patterns
capital :: String -> String
capital "" = "Empty string"
capital all@(x:xs) = "The whole string is " ++ all ++ " The first part is " ++ [x]