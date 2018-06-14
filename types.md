# Types and Typeclasses

Haskell has a static type system, which allows the typing to be checked at compile time. _Everything_ in Haskell has a type. Haskell also has type inference which means that the compiler can infer the type of values and functions on its own. This works well in unambiguous situations. When defining a non-trivial function it is recommended to include the typing.

Types are defined for functions by using the `::` operator. The type shows the mapping of the input type onto the output type. The last type is the output type and the all the types that come beforehand are the input types.

```haskell
-- example: functionName :: InputType -> OutputType

-- for multiple inputs values: functionName :: InputType1 -> InputType2 -> ... -> OutputType

removeNonUppercase :: [Char] -> [Char]
removeNonUpperCase st = [c | c <- st, c `elem` ['A'..'Z']]

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z
```

## Common Types

* `Int`: Bounded integer values. The max bound is dependent on the machine archictecture. On 32-bit machines the max is 2^31-1 and on 64-bit, the max bound is 2^63 - 1.

* `Integer`: Unbounded integer values. This can be used to represent values bigger than the bounds of `Int`. However, if the large value is not needed, `Int` is a better choice as it is more efficient.

* `Float`: Single precision floating point.

* `Double`: Double precision floating point.

* `Bool`: Boolean type. Can only be `True` or `False`.

* `Char`: Character type. Denoted by `''` around a character.

## Type Variables

In Haskell, types not in capital case are a `type variable`. This means that type can be of any type. This is similar to generics in other languages. This allows for functions to be general if they don't rely on specific features of the types. This feature allows functions to be polymorphic.

```haskell
:t head
head :: [a] -> a

:t fst
fst :: (a, b) -> a
```

## Typeclasses

Typeclasses are a very interesting Haskell feature. They allow for defining generic interfaces that all types belonging to that typeclass must provide. The way this works is by defining a set of functions that are implemented differently depending on the type of data.

```haskell
:t (==)
(==) :: (Eq a) => a -> a -> Bool
```

The above type can be read as `==` has a class constraint that is symbolized by `=>` symbol. The `==` function can take two values of same type and return a `Bool`. The type of the values must belong to the `Eq` type class, which was the class constraint.

### Some Common Typeclasses

* `Eq`: This is used for any types that support equality testing. The functions that any members of this typeclass must implement are `==` and `/=`. The previously discussed types are all members of the `Eq` class.

```haskell
5 == 5
True
5/= 5
False
'a' == 'a'
True
```

* `Ord`: Types that have an ordering. All previously discussed types are part of this typeclass. the `>`, `<`, `>=` and `<=` are parts of the `Ord` typeclass. There is a `compare` function that takes two values of same type belonging to `Ord` and returns an `Ordering`. `Ordering` is a type that has values `GT`, `LT` and `EQ` for greater than, lesser than and equal to. In order for types to be a part of `Ord`, they must first be a part of the `Eq` typeclass. 

```haskell
:t (>)
(>) :: (Ord a) => a -> a -> Bool

:t compare
compare :: Ord a => a -> a -> Ordering

"Abra" < "Zebra"
True

compare "Abra" "Zebra"
LT

5 >= 2
True

5 `compare` 2
GT
```

* `Show`: Allows values of types belonging to this class to presented as strings. The function `show` is used to present values as strings. 

```haskell
show :: Show a => a -> String

show 3
"3"
show 5.334
"5.334"
show True
"True"
```

* `Read`: Takes a string and returns the value with type that is a member of this typeclass. This funciton is implemented using the `read` function. If the result from `read` is used, GHC can infer the type it needs to read. If no type annotation is provided and the result is not used, `read` will result in an error. *Type Annotations* are defined using the `::` operator with the type following the operator. 

```haskell
read :: Read a => String -> a

-- Valid Examples
read "True" || False  
True
read "8.2" + 3.8  
12.0
read "5" - 2  
3
read "[1,2,3,4]" ++ [3]  
[1,2,3,4,3]


-- Invalid Examples

read "4"
*** Exception: Prelude.read: no parse
read "True"
*** Exception: Prelude.read: no parse

-- Valid with type annotations
read "5" :: Int
5
read "5" :: Float) * 4
20.0
read "[1,2,3,4]" :: [Int]
[1,2,3,4]
read "(3, 'a')" :: (Int, Char)
(3, 'a')
```

* `Enum`: Sequentally ordered types belong to this typeclass. Members of this typeclass provide `succ` and `pred` functions which serve as successors and predecesors. The types belonging to `Enum` are `()`, `Bool`, `Char`, `Ordering`, `Int`, `Integer`, `Float` and `Double`

```haskell
:t succ
succ :: Enum a => a -> a

['a'..'z']
"abcdefghijklmnopqrstuvwxyz"
[LT .. GT]
[LT,EQ,GT]
[3..5]
[3,4,5]
succ 'B'
'C'
```

* `Bounded`: Member types of this typeclass have an upper and a lower bound. The functions which are implemented are `minBound` and `maxBound`. Tuples can be part of `Bounded` as well if all the components of a tuple are members as well.

```haskell
:t minBound
minBound :: Bounded a => a

minBound :: Int  
-2147483648
maxBound :: Char  
'\1114111'
maxBound :: Bool  
True
minBound :: Bool  
False
```

* `Num`: Numeric typeclass including real and integral numbers. Whole numbers types belonging to `Num` typeclass are polymorphic constants and can act as any type that is a member of the `Num` typeclass. In order for a type to be a member of `Num` typeclass, they must belong to `Show` and `Eq` as well. 

```haskell
:t 20
20 :: (Num t) => t

20 :: Int  
20
20 :: Integer  
20
20 :: Float  
20.0
20 :: Double  
20.0

:t (*)
(*) :: (Num a) => a -> a -> a
```

* `Integral`: Types of integral, read whole, numbers. 'Int' and 'Integer'

* `Floating`: Types of floating point numbers. 'Float' and 'Double'

A pretty cool function is `fromIntegral` which takes value of `Integral` type and returns a `Num` value.

```haskell
:t fromIntegral
fromIntegral :: (Integral a, Num b) => a -> b
```