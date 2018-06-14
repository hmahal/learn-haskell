# Some Haskell Basics

## Basic Functions

* Defining a function without typing:

```haskell
function_name param1 param2 ... = function_body
```

* We can use `'` to denote a strict, non-lazy version of the function. It is valid to name functions with `'` i.e. `somethingNew'`.

## Conditionals

* Conditional Statements:

```haskell
if condition then if_condition_true else if_condition_false
```

Unlike most other languages, the else part is mandatory. The conditional statement is an _expression_, therefore it must return a value. Other examples of _expressions_ are `4 + 8` which returns `12`.

## List Basics

* List in Haskell are homogenous. That means the data type of list elements must be the same.

```haskell
let aList = [4, 5, 6, 7, 8] -- Valid
let bList = [4, 5, 'a', 'b'] -- Invalid
```

* Strings are a list of characters. Therefore `"hello"` is the same as `['h', 'e', 'l', 'l', 'o']`

* Lists can combined using the `++` operator. The data type of both lists must be the same. However, overusing this operator can lead to _performance issues_ since the operator causes all of the the left side list to be traversed.

```haskell
[1,2,3,4] ++ [9,10,11,12] -- Valid
"hello" ++ " " ++ "world" -- Valid
['w','o'] ++ ['o','t']    -- Valid, returns "woot"
```

* In order to append in front of a list, use the `:` operator.

```haskell
'A':" small world" -- "A small world"
5:[1,2,3,4] -- [5,1,2,3,4]
```

* Important to note, `[1,2,3]` is the syntactic sugar for `1:2:3:[]` where `[]` is an empty list.

* In order to get an item at a certain index, `!!` operator is used.

```haskell
"Hello" !! 4 -- Returns 'o'
"Hello" !! 5 -- Invalid, returns error
[1,2,3,4] !! 0 -- Returns 1
```

* Lists containing values with same type can be compared using `<`, `<=`, `>`, `>=`  and `==` operators. The comparison returns boolean values `True` or `False`. The lists are compared lexographically.

```haskell
[3,2,1] > [2,1,0] -- True
[3,2,1] > [2,100,1000] --True
[3,2,1] > [3,4,1] --False
```

## List Operations

* _head_: returns the first element of the list

```haskell
head [1,2,3,4,5]
1
```

* _tail_: returns all but the first element in a list

```haskell
tail [1,2,3,4,5]
[2,3,4,5]
```

* _last_: returns the last element of the list

```haskell
last [1,2,3,4,5]
5
```

* _init_: returns all but the last element of the list

```haskell
init [1,2,3,4,5]
[1,2,3,4]
```

* _length_: returns the list length

```haskell
length "Hello"
5
length [1,2,3,4,5]
5
```

* _null_: returns `True` if empty, `False` otherwise.

```haskell
null [1,2,3]
False
null []
True
null ""
True
null "Hello"
False
```

* _reverse_: reverses a list.

```haskell
reverse "hello"
"olleh"
reverse [1,2,3]
[3,2,1]
reverse []
[]
```

* _take_: Extracts the specified number of elements from beginning of the list.

```haskell
take 3 [1,2,3,4,5,6]
[1,2,3]
take 0 [1,2,3,4]
[]
take 3 "hello"
hello
take 5 [1,2]
[1,2]
```

* _drop_: Similar to take, drops the specified elements from the list.

```haskell
drop 3 "hello"
"lo"
drop 2 [1,2,3,4]
[3,4]
drop 100 [1,2,3,4]
[]
```

* _maximum_: Returns the largest element in the list

```haskell
maximum "abz"
'z'
maximum [1,2,3,4]
4
maximum "" -- Error
maximum [] -- Error
```

* _minimum_: Returns the smallest element in the list

```haskell
minimum "abz"
a
minimum [1,2,3,4]
1
minimum "" -- Error
minimum [] -- Error
```

* _sum_: Takes a list of numbers and returns their sum

```haskell
sum [1,2,3,4]
10
sum "hello" -- Error
sum []
0
```

* _product_: Takes a list of numbers and returns their product

```haskell
product [1,2,3,4]
24
product []
1
product "hello" -- Error
```

* _elem_: Takes an item and a list of items of same type and returns `True` if the item is in the list and `False` otherwise.

```haskell
elem 4 [1,2,3,4]
True
elem 10 [1,2,3,4]
False
elem 10 []
False
elem 'h' "hello"
True
elem 'h' ""
false
```

## List Construction

In Haskell, we can generate lists using in built language features.

* Using `..` we can build out lists. For example:

```haskell
[1..20]
[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
['a'..'z']
"abcdefghijklmnopqrstuvwxyz"
['K'..'Z']
"KLMNOPQRSTUVWXYZ"
```

* In order to specify steps in the sequence, we need to provide the first two values of the sequence. Specifying more than 1 step does not work.

```haskell
[2,4..20]
[2,4,6,8,10,12,14,16,18,20]
[3,6..20]
[3,6,9,12,15,18]
['a','c'..'z']
"acegikmoqsuwy"
```

* In order to build lists in a descending order, you must specify the first step as well.

```haskell
[20,19..1]
[20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1]
['z','y'..'a']
"zyxwvutsrqponmlkjihgfedcba"
```

* It is best to avoid ranges when using floating point numbers because it can yield inaccurate results.

```haskell
[0.1, 0.3 .. 1]
[0.1,0.3,0.5,0.7,0.8999999999999999,1.0999999999999999] --YIKES!
```

## Infinite List Construction

* The easiest way to build infinite lists is not specify an upper bound

```haskell
take 24 [13, 26..]
[13,26,39,52,65,78,91,104,117,130,143,156,169,182,195,208,221,234,247,260,273,286,299,312]
```

Because Haskell evaluates it lazily, Haskell will get the 24 multiples of 13 and then exit out of building rest of the list. Pretty nifty!

* _cycle_: Takes a list and cycles it into infinite list.

```haskell
take 9 (cycle[1,2,3])
[1,2,3,1,2,3,1,2,3]
take 6 (cycle "Hi ")
"Hi Hi "
```

* _repeat_: Takes an element and repeats it infitely.

```haskell
take 5 (repeat 5)
[5,5,5,5,5]
```

* _replicate_: Repeats a given element for the specified number of times

```haskell
replicate 3 10
[10,10,10]
```