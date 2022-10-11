-- LYAH Guide

{-
Haskell is (the basics):
- A purely functional programming language, i.e. it does not use statements or instructions, but relies rather on expressions. Functions are "pure" in the sense that they have a
mathematical counterpart (e.g. f(x) in pure mathematics == f x in Haskell, more on this later).
- Immutable, i.e. expressions cannot mutate already defined variables (e.g. if you say pizza = "good", pizza is good for the life of the program in which pizza is defined as "good",
you can't later on in your program declare that pizza is now "bad", you already said it was "good" (aside from overwriting the existing expression and making pizza eternally "bad".)
Once a ___, always a ___, when defined, now, and forever.
- Statically typed, i.e. the variables types are known at compile time. Haskelly additionally uses type inference, i.e. types do not have to be explicitly declared (though it is
recommended to do so.)
- A lazy programming language, i.e. functions don't evaluate their arguments.

Getting Started:

Haskell is maintained at haskell.org, installation instructions can be found here: https://www.haskell.org/downloads/. Haskell primarily uses the "Glasgow Haskell Compiler (GHC)". Once
Haskell is installed, type 'ghci' in a terminal/CLI to invoke the GHCI interface. Arithmetic and Boolean algebra work as expected in ghci, where &&, ||, not, True, and False are used, and "=="
is used for testing equality.

As usual, the argument types must match for comparison, and must be of an eligible type for operation (e.g. + only works on numbers, etc). Additionally, integers (e.g. 1, 2, 3) can act as floating
point if need (e.g. 5 + 4.0 outputs 9.0), but floating point (e.g. 4.0) cannot act as an integer. Note that 5 == 5.0 outputs True. Interestingly, division yields a floating point output even
in the event that the inputs are integers, while multiplication yields a floating point output iff one (or more) of the inputs are floating point (or so it seems through a few samples).
E.g. 5/5 outputs 1.0, 5 * 5 outputs 25, 5 * 5.0 outputs 25.0.

"Infix" functions are functions that are sandwiched between their arguments (e.g. * is in infix function in 5 * 5, + is an infix function in 5 + 5, and so on). Most functions that aren't used with
numbers are "prefix". The majority of functions are prefix. 

In most imperative languages, functions are called by writing the function name and then writing its parameters in parentheses, usually separated by commas. In Haskell, functions are called by
writing the function name, a space and then the parameters, separated by spaces (e.g. f(x) becomes f x, and so on). An example is succ 8, which outputs 9.

DEFINITION: The succ function takes anything that has a defined successor and returns that successor.

Calling a function with several parameters is done similarly, with a space between each parameter (e.g. f(x, y) becomes f x y). For example, min 9 10 outputs 9, max 100 101 outputs 101, and so on.
Note that min and max only take two arguments (e.g. max 1 2 3 upsets GHCI)

Function application (calling a function by putting a space after it and then typing out the parameters) has the highest precedence in order of operations (like the P in PEMDAS). So, for example,
the following two statements are equivalent:

succ 9 + max 5 4 + 1, and
(succ 9) + (max 5 4) + 1

and output 16. Also note that this means that parenthesis can be used to make precendence explicit (i.e. as in the second line above, which is arguably more readable), or change it.
For example, the following statement:

succ 9 + max 5 (4 + 1)

changes the precendence as the parentheses around the 4 + 1 enforce a higher precendence on that addition operation, which would otherwise take place after the application of max. The output in
this case becomes 15, as succ 9 = 10, and max 5 (4 + 1) = max 5 (5) = max 5 5 = 5.

SYNTAX: If a (prefix) function takes two parameters, we can call it as an infix function by surrounding it with backticks. The function div, for example, does integral division on two arguments,
with the first argument as the numerator, so that div 99 10 = 9, which is equivalent to 92 `div` 10 with div in infix form.

As imperative languages use parentheses to denote function application (e.g. max(5, 10)) it is important not to confuse a Haskell statement such as:

div (max 4 5) 1, with, for example:
div max 4 5 1

The first statement above is the appropriate way to compute the (integral) quotient of the max of two numbers and another number. This is NOT saying that the first div takes max, 4, and 5 as
parameters, it is saying that div takes the output of max 4 5 (i.e. 5), and thus div takes 5 and 1 as parameters (and i.e. outputs 5). Note that max 4 5 is a number! 
-}

-- To define a function, the function name is given, followed by space, followed by its parameter (or parameters), followed by an equal sign, followed by its definition.  If there is more than
-- one parameter, a space is required between each parameter. For example:

doubleMe x = x + x

-- The function above is called "doubleMe", it takes one parameter as input (represented by x), and it adds the input to itself (x + x), thus doubling the input. The function call, doubleMe 5,
-- for example, outputs 10.

-- Haskell code is saved as either .hs or .lhs (l for literal), and loaded in GHCI by :l {filename}, or :r to re-load the previously loaded file. If .lhs, > is needed as a prefix, followed by a space
-- on each line that should be treated as Haskell code. If .hs (like this one), lines are treated as Haskell code by default, and comments are invoked via "--" (single line), or "{- -}" (multi-line).

-- Function type signatures look like this:

doubleMe :: Integer -> Integer

-- The type signature of a function starts with the function name, followed by a :: (space separated), followed by the type of input it takes and the type of output it produces (open question):
-- can Haskell functions take multiple inputs and/or produce multiple outputs (e.g. https://wiki.haskell.org/Composing_functions_with_multiple_values).
-- The type signature is optional (but recommended) and would come above the function definition, for example:

squareMe :: Integer -> Integer
squareMe x = x * x

-- Note that attempted to do something like squareMe :: Integer -> Bool makes GHCI grumpy.

-- INSIGHT: Functions and expressions are immmutable, i.e. once defined, they can not be changed/redefined. So, doubleMe above is always defined as it is (unless the existing definition is deleted
-- and the script recompiled, only then can the function be defined anew). Similarly, the below expression:

spooky = 2

-- Means that spooky is equal to 2, and so long as the expression spooky = 2 exists in this code, spooky cannot equal anything else. spooky can be used elsewhere and will be read as a 2, for example:

addMeToSpookysAge :: Integer -> Integer
addMeToSpookysAge x = spooky + x

-- creates a function that takes an Integer as input and adds it to spookys age, since spooky is 2 (and thus we defined spooky as spooky = 2), the input addMeToSpookysAge 5 outputs 7. If we
-- want a more precise age definition, we could do:

{- hmm, open question, the below doesn't work and I thought it should:
addMeToSpookysAgePrecisely :: Float -> Float
addMeToSpookysAgePrecisely x = x + spooky
-}

doubleUs :: Float -> (Float -> Float)
doubleUs x y = x * 2 + y * 2

-- INSIGHT: The above function takes two value arguments as input and yields a single value as output, and so the type signature requires three declared types (i.e. Float -> Float -> Float). Note
-- that this is equivalent to (Float -> (Float -> (Float)))

-- HACK: writing :info {functionName} in GHCI shows you the function definition, you can also do :? for a more comprehensive list of thigs that can be done























{-
Misc Notes and resources:

- NOTES:

- Lambda calculus is invoked with backslash

RESOURCES:

- Online codelabs:
-- LYAH website: http://learnyouahaskell.com/starting-out
-- RWC website: http://book.realworldhaskell.org/read/data-structures.html
--> Implement these Colabs as prep for the assignment with strobe etc
- Write IYOW explanations of each of the exercise in the solution implementation (i.e. in code comments or in a Haddock type)
-}
