# Functions

These notes deal with function types in Haskell. 

## Functions and types

### What is a function?
A function is a mapping from arguments of one type to result of another type. E.g.

```haskell
not :: Bool -> Bool
even :: Int -> Bool
```

One important thing to note is that there is no restriction that function argument types cover all possible argument types. I.e. There can still be arguments that can lead to undefined behaviour. An easy example for this is the `head` function for a list. On `head []`, we encounter an exception due to an empty list. 

### Curried Functions

