# List Comprehension & Tuples

A _list_ is a sequence of elements of the same type. The syntax is similar to arrays in most languages, `[]`. Lists containing a single element are called _singleton_ lists. The type of a list can be denoted as `[Type]`. E.g. a list of boolean values, `[True, False, False]` can be denoted as `[Bool]`. 

An important thing to note with lists is that lists in Haskell can be _infinitely_ long, due to the use of lazy evaluation.

## List Comprehension

* In Haskell in order to perform operations on a list, list comprehension can provide a concise way. In the following example, `x` is drawn for the list `[1..10]` and the element is then doubled.

```haskell
-- [operation to be performed on value | value <- list value is drawn from]
[x*2 | x <- [1..10]]
[2,4,6,8,10,12,14,16,18,20]  
```

* Predicates can be included in list comprehension by being separated from the list by a comma. Multiple predicates can be included separated by commas as well.

```haskell
-- Basic List Comprehension
[x*2 | x <- [1..10], x*2 >= 12]
[12,14,16,18,20]


-- List Comprehension with function
boomBang xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
boomBangs [7..13]  
["BOOM!","BOOM!","BANG!","BANG!"]

-- Multiple Filtering predicates
[ x | x <- [10..20], x /= 13, x /= 15, x /= 19]
```

* Similar to multiple predicates, we can pass multiple lists that need to be operated on in list comprehension.

```haskell
[x*y | x<- [2,5,10], y<- [8,10,11], x*y > 50]
[55,80,100,110]
```

* If we don't care about the values we draw from the list, we can use `_` character. This is useful for counting values in list that pass the filter.

```haskell
-- example of length function with list comprehension
length' xs = sum[1 | _ <- xs]
```

* Since strings in Haskell are simply lists as well, we can use list comprehension to operate on strings as well.

```haskell
removeNonUpperCase st = [c | c <- st, elem c ['A'..'Z']]
removeNonUpperCase "Hahaha! Ahaha!"
"HA"
```

## Tuples

Formally, a _tuple_ is _finite_ sequence of components, with the possibility of components having different types.

Tuples in Haskell are similar to lists as they store multiple different values into a singular value. The difference however is quite important.

1. Lists store value of a single type and do not care about how many values are stored in the list. Tuples however contain the number of values stored in them. The type of a tuple contains how many values it has and the type of the values.

2. As mentioned above, tuples do not have to be homogeneous.

3. Tuples are defined using `(x,y,z)` rather than `[]`.

Tuples should be used when the number of values is known. You cannot write general functions to append to tuples as different sized tuples are different types. There is no type as a singleton tuple as it would only contain a singular value and not provide any additional benefit.

The number of elements in a tuple is called its _arity_. Another important thing to note is that tuples of arity one, e.g. `(1)` are not allowed. The type of a tuple conveys its arity. There is no restriction on the types that can make up a tuple. Last thing to note is that, the types of the tuple and tuple components is inferred prior to evaluation.

```haskell
[(1,2),(3,4,5),(6,7)] -- will result in error as the middle tuple is of a different type
[(1,2),("One",2)] -- will result in error as the two tuples are of different types
```

* _fst_: takes a pair, (tuple with two values) and returns the first component

* _snd_: takes a pair and returns the second component.

```haskell
fst (8,11)
8
snd(8,11)
11
```

Important to note that these operations *only work on pairs*.

* _zip_: Zip is an important function that takes two lists and produces a single list by joining the elements with matching indices into pairs. It is useful for combining two lists or traverse them simultaneously. Zip can take two lists of different sizes and produce a single list of size of the smaller list. Zip can also take lists that contain values of different types as well.

```haskell
zip [1,2,3,4,5] ['a', 'a', 'a', 'a']
[(1,'a'),(2,'a'),(3,'a'),(4,'a')]
```
