# CountdownNumberGame
A countdown number game for theory of algorithmns project using functional programming

### Algorithm 
I used remove-duplicates built in function to remove repeated statements in order
to make the problem smaller. And then working on making it a valid RPN.

Map adds two numbers to start of all permutations and adds one operator to the end of permutations

Working on checking if a function is valid for RPN and need to apply the function to 
every element of the list/stack and some equations are still not valid from my code. Also
remove-duplicates cant get inside nested lists.

The cartesian-product gets the combinations of a different lists. So in this case we get the 
combinations of all the operators for an equation. 
Example:

```racket
> (cartesian-product '(1 2 3) '(a b c))
'((1 a) (1 b) (1 c) (2 a) (2 b) (2 c) (3 a) (3 b) (3 c))
```