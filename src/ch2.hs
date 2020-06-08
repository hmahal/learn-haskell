n = a `div` length xs
    where
        a = 10
        xs = [1,2,3,4,5]

last' x = x !! (length x - 1)

last'' x = reverse x !! 0

init' x = reverse( drop 1 (reverse x))

init'' x = reverse( tail (reverse x))
