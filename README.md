# CountdownNumberGame
A countdown number game for theory of algorithmns project using functional programming

### Research
Firstly, I set up issues on github. It was nothing pacific but my personal sort of
to do list of what i think the way of approaching it could be.
I practiced racket by attempting the problem sheets that I received in college.
Next, I watched countdown to clarify rules as I was not familiar to the process of countdown.

I then googled countdown numbers game http://happysoft.org.uk/countdown/numgame.php

### Programming Practice
Firstly, when beginning this project I generated a list of the numbers to get started 
and get used to racket and using the racket documentation. So as I was practicing racket it has 
reference to the actual countdown game itself.
 After I programmed a random generator and the 6 random digits from
a set list of figures,  if i had experience with
racket i would have jumped straight to the algorithm. 

When this was finished I needed to focus on the algorithm and try wrap
my head around how ill go about it. This was a lot more difficult than I initially expected but 
in our lecture we were told to try start small with 2 numbers using combinations and permutations.

For example:
------------
Say the tarket was 10:
```racket
(define a 2)
(define b 5)
(+ a b)
(- a b)
(/ a b)
(* a b)
(+ b a)
(- b a)
(/ b a)
(* b a)
```

This will populate the answer with 2 possibilities.
Adding 3 possibilities adds difficulty and adding four adds more difficulty. This system obviously is not going to be very
efficient as it would be 11! (11 factorial) which is 39916800. So considering how big the problem is we need to shorten the amount.
remove-duplicates is a built in function in racket which will reduce that number significantly.


This is where **reverse polish notation** comes in.RPN is a mathematical notation in which every operator follows all of its operands so 
doesnt matter which order. However to be a valid RPN equation you must for example have at least 2 numbers on the stack than the operator
and the end of the stack has one number  

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