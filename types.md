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