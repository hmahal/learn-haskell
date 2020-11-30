# Function Syntax in Haskell

This part introduces some syntactic features of Haskell that are really useful for writing simpler and readable code. At the end of this chapter, I should have enough knowledge of Haskell syntax and conventions so that I can write basic functions.

## Pattern Matching

Pattern matching is similar to defining piecewise functions in math. When the function is defined, different patterns can be assigned different 'function body'. When the function is called, the arguments are matched with the argument patterns.

```haskell
lucky :: (Integral a) => a -> Strinng
lucky 7 = "Lucky number seven!"
lucky x = "Sorry, all out of luck"

sayMe :: (Integral a) => a -> String
sayMe 1 = "One"
sayMe 2 = "Two"
sayMe 3 = "Three"
sayMe x = "Not between 1 and 3"
```

The thing to note here is that there is a catch-all pattern designated by `x` in both of the examples above. This needs to go at the bottom because if it is placed before other patterns, it will match **any** pattern and bind it to `x`. The important thing to remember here is that the ordering of the patterns is really important and should go from the most specific to the most general pattern.

```haskell
-- Example with recursion
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial(n - 1)
```

But you need to be careful when defining patterns. See below:

```haskell
charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"

charName 'a'
"Albert"
charName 'd'
"*** Exception: example.hs:(2,1)-(4,22): Non-exhaustive patterns in function charName
```

This example throws an error because there is no catch-all pattern. Because none of the patterns are matched, the program crashes due to an exception.

We can also use pattern matching when we work with tuples. Before I knew about pattern matching, I would have used the `fst` and `snd` functions when working with pairs, but we can also do it using pattern matching. See below:

```haskell
--Old Way
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors a b = (fst a + fst b, snd a + snd b)

--Pattern Matching Way
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1), (x2, y2) = (x1 + x2, y1 + y2)
```

The thing to note is that the typing for the function remains the same. In my opinion, with pattern matching, the function becomes much more readable.

Now that I know about this powerful feature, I can make functions such as `fst` and `snd` for tuples with more than 2 values. Watch:

```haskell
-- First, Second and Third values of the tuple size 3
first :: (a, b, c) -> a
first (x, _, _) = x

second:: (a, b, c) -> b
second (_, y, _) = y

third:: (a, b, c) -> c
third (_, _, z) = z
```

The `_` means that I don't care about the values other than the one I want to extract using the function. So in `first`, I don't really care about `y` or `z` values. As long as the tuple matches the pattern, i.e. it has 3 values, the functions will work.

The cool thing is, list comprehension and pattern matching can be combined together. If I want to add a pair of tuples in a list, I can add pattern matching to make sure that the values in a list match the pattern of a pair.

```haskell
let xs = [(1,2), (4,5), (6,7)]
[a+b | (a,b) <- xs]
[3,8,13]
```

Pattern matching can be used to work on lists as well. I can match `[]` as a pattern and `:`  with `[]` as a pattern too. A common pattern that gets used in Haskell is `x:xs`. This pattern binds the head of the list to `x` and rest of the list to `xs`. This can be extended further to something like `x:y:z:zs`, where the first three elements are bound to `x`, `y` and `z` and rest of the list is bound to `zs`. This pattern works because the `[1,2,3]` syntax is just sugar for `1:2:3:[]`. Using this knowledge we can define our own head function.

```haskell
head' :: [a] -> a
head' [] = error "Can't call head on an empty list."
head' (x:_) = x

head' []
*** Exception: Can't call head on an empty list.

head' [1,2]
1
```

Two things to notice are:

1. If we want to bind values to multiple variables, we need to use `()`. That's we see `(x:_)` used. It doesn't matter if we are binding to `_` and just discarding the other values.

2. We used `error` keyword. We can see that an exception occurs when we try to use this function on an empty list. `error` takes a string as an error message and generates a runtime error. But we should be cautious when throwing `error` as it does cause program to crash.

Let's try to create a more robust function that covers all the bases.

```haskell
tell :: (Show a) => [a] -> String
tell [] = "Empty list"
tell (x:[]) = show x
tell (x:y:[]) = show x ++ " " ++ show y
tell (x:y:_) = show x ++ " " ++ show y ++ " ..."

tell []
"Empty list"
tell [1]
"1"
tell [1,2]
"1 2"
tell [1..2]
"1 2 ..."
```

The function above covers all cases for lists, empty, single element or `singleton`, two element list and list with more than two elements. A better way to write `(x:[])` would be `[x]`. Similarly, `(x:y:[])` can be written as `[x,y]`. But there is no way to rewrite the `(x:y:_)` pattern.

I implemented a length function previously using list comprehension. I can rewrite it using pattern matching as well. Like so:

```haskell
length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

length' []
0
length' [1]
1
length' [1,2]
2
```

The `length'` function gets called recursively where the base case is an empty list. We `_` because we don't actually care about the value of list head, just that it exists. Similarly, we can define function such as `sum`.

```haskell
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

sum' []
0
sum' [1,2]
3
sum' ['a','b']
*** No instance for (Num Char) arising from a use of sum'
```

Same as before, the base case is sum 0 for empty list and rest can be done recursively by adding `x` to the `sum'` of the rest of the list.

Last thing about pattern matching is that we can use something called _patterns_. Patterns allow us to keep a reference to the whole thing while we break it up using pattern matching. This is useful for working with lists in pattern matching and preventing yourself from typing out the pattern over and over again in function body. An example is below.

```haskell
capital :: String -> String
capital "" = "Empty string"
capital all@(x:xs) = "The whole string is " ++ all ++ " The first part is " ++ [x]

capital "Hello"
"The whole string is Hello The first part is H"
```

I need to spend more time to properly explain _patterns_ but that is all for now. I have added `examples.hs` file which has some functions I used as examples in this file.

## Guards

So previously, we looked at pattern matching as a way to 'guide' to a particular function body based on the value conforming to a form. Guards let us check whether the value contains some property or another. Guards are an alternative to using if-else statements. Guards make it more readable to have multiple conditions and work well with patterns.

Guards use the 'pipe' operator `|`. The statement following the operator is a boolean statement; if the statement is evaluated to `True`, the corresponding function body is used. If the statement is `False`, checking is dropped to the next guard down.

Often, we use `otherwise` as the last guard. `otherwise` is defined as always being true and catches everything that falls to it. We can combine patterns and guards by omitting `otherwise` and letting the evaluation 'fall' to the next pattern.

In pseudo-code, it looks something like:

```haskell
functionName :: (Type a) => a -> ReturnType
functionName param
  | param with bool statement = function body
  | param with bool statement = function body
  | param with bool statement = function body
  | param with bool statement = function body
  | otherwise = defaultFunction
```

When using guards, sometimes we use the same expressions multiple times and end up repeating ourselves. (See `bmiTellWithCal` in guard_examples.hs) We can use the `where` keyword in order to make our code more readable and define names or functions. We can actually define multiple names/functions in `where` which makes it super useful. So we can rewrite our BMI function as following:

```haskell
bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
  | bmi <= 18.5 = "You're underweight, you emo, you!"  
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
  | otherwise   = "You're a whale, congratulations!"  
  where bmi = weight / height ^ 2  
```

One thing to note is that the scope of the `where` bindings is only within the pattern that they are defined in. In order for multiple patterns to access the functions/names, they need to be defined globally.

We can also use where bindings to pattern match, extending our previous example, we can do:

```haskell
...
where bmi = weight / height ^ 2
      (skinny, normal, fat) = (18.5, 25.0, 30.0)
```

One last thing about the where bindings is that they can be nested. So when defining a function within `where`, we can give those functions their own `where` clauses too.

## Let

In progress

## Case Expressions

In progress
