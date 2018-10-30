-- BMI berator using guards
bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
  | bmi <= 18.5 = "Too low"
  | bmi <= 25.0 = "Just right"
  | bmi <= 30.0 = "Too high!"
  | otherwise   = "Better watch yourself"

-- BMI berator with calculation
bmiTellWithCalc :: (RealFloat a) => a -> a -> String
bmiTellWithCalc weight height 
  | weight / height ^ 2 <= 18.5 = "Too low"
  | weight / height ^ 2 <= 25.0 = "Just right"
  | weight / height ^ 2 <= 30.0 = "Too high!"
  | otherwise   = "Better watch yourself"

-- Self defined max using guards
max' :: (Ord a) => a -> a -> a
max' a b
  | a > b = a
  | otherwise = b

-- Returns the initials, given first and last name using where
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
  where (f:_) = firstname
        (l:_) = lastname

-- Calculates BMI for a list of weight height pairs
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w h) <- xs]
  where bmi weight height = weight / height ^ 2