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