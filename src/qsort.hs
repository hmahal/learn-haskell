{-
 - Nested comments are cool
 -}
--Quicksort
qsort []        = []
qsort (x:xs)    = qsort smaller ++ [x] ++ qsort larger
                  where
                    smaller = [a | a <- xs, a < x]
                    larger  = [b | b <- xs, b > x]

--Reverse qsort
reverseQsort []     = []
reverseQsort (x:xs) = reverseQsort larger ++ [x] ++ reverseQsort smaller
                      where
                        smaller = [a | a <- xs, a <= x]
                        larger  = [b | b <- xs, b > x]
