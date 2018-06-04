# Some Haskell Basics:

Notes for [Learn You a Haskell for Great Good!](http://learnyouahaskell.com)

### Basic Functions:
* Defining a function without typing:
```haskell
function_name param1 param2 ... = function_body
```

* We can use `'` to denote a strict, non-lazy version of the function. It is valid to name functions with `'` i.e. `somethingNew'`.

### Conditionals:
* Conditional Statements:
```haskell
if condition then if_condition_true else if_condition_false
```
Unlike most other languages, the else part is mandatory. The conditional statement is an _expression_, therefore it must return a value. Other examples of _expressions_ are `4 + 8` which returns `12`.

### List Basics:
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

### List Operations:
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

* __null__: returns `True` if empty, `False` otherwise.
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