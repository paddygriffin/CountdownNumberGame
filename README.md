# CountdownNumberGame
A countdown number game for theory of algorithmns project using functional programming
#### Patrick Griffin
#### G00314635
#### Theory Of Algorithms
#### Ian McLoughlin

### Introduction
--------------------
In the Countdown Numbers game contestants are given six random numbers
and a target number. The target number is a randomly generated three digit
integer between 101 and 999 inclusive. The six random numbers are selected
from the following list of numbers:
[1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 25, 50, 75, 100]

In this application I tried to generate the random number between the random and generate a
list of random numbers and try and calculate it.

### How to Run:
----------------------
To run this project firstly you will need racket downloaded and installed found [here](http://racket-lang.org/download/).
- Clone this repository https://github.com/paddygriffin/CountdownNumberGame.git
```
 git clone https://github.com/paddygriffin/CountdownNumberGame.git
 ```
- File -> Open -> .../countdown/CountdownNumberGame.rkt
- You can also download the project and open it from there.

### Research
--------------------
Firstly, I set up issues on github. It was nothing specific but my personal sort of
to do list of what i think the way of approaching it could be.
I practiced racket by attempting the problem sheets that I received in college.
Next, I watched countdown to clarify rules as I was not familiar to the process of countdown.

I then googled countdown numbers game http://happysoft.org.uk/countdown/numgame.php

### Programming Practice
------------------------
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
doesnt matter which order. However to be a valid RPN equation you must for example have at least 2 numbers on the stack than the operator and the end of the stack has one operator  
![RPN](https://github.com/paddygriffin/CountdownNumberGame/blob/master/image/RPN.jpg "Reverse Polish Notation example")

### Issues
Crashed when too many numbers due to memeory.
difficult to get my head around.
Not fully working

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

I couldnt get the cartesian-product to work from code given in class. But my idea was to get two lists together
in order to provide an equation but was a fail.

To make sure that two numbers were at the beginning of the code and an operator at the end:
```racket
(define (to-rpn l)
  (cond [(valid-rpn? (append numbers2 l selectOp))
   (calculate-RPN (append numbers2 l selectOp))]))
```

 so I found a calculate-rpn function online and tried
to incorporate that into my program.(Link in code)

So, I check if its a valid RPN and append the list and if it is I calculate-rpn.
Here is to check if its valid RPN which I got from class:
```racket
(define (valid-rpn? e (s 0)) ;default value is 0
  (if (null? e)
      (if (= s 1) #t #f)
      (if (number? (car e) )
          (valid-rpn? (cdr e) (+ s 1))
      (if (> s 1)
          (valid-rpn? (cdr e) (- s 1))
          #f)))) ;true ot false
```

I ended up creating two different function one to get 4 rabdom numbers and the other two random numbers as
RPN needs two numbers at the beginning of the list to be valid.
Code Example:
```racket
(define numbers4 (list));Creates list for selecting 4 numbers
(define (randomListNumbers l);Creates list for random numbers  
  (define randomNumber(list-ref l(random (length l))))  
  (set! l(remove randomNumber l)) 
  (set! numbers4 (cons randomNumber numbers4))  
  (if (= (length numbers4) 4)
     numbers4 ;Prints 4 random numbers
      (randomListNumbers l))
)
```

I then created functions one to get 4 random operands and the other one operand for the end
of the list to be valid RPN. I then appended the list.

```racket
 (define allPerms(remove-duplicates (permutations (append select4Ops numbers4))))
```

### Conclusion
This project was difficult to grasp but firstly, I did all the code we got in class and then adapted that code 
with all of my own random generators but stuck with the same sort of algorithm given in class. So if I had to 
repeat the same project. firstly, instead of jumping straight into the code I would have thought about how big the problem is for 
example the 11! of the list of numbers and operators.


### References
- https://docs.racket-lang.org/ - Racket Documentation
- http://stackoverflow.com/questions/14674165/scheme-generate-random   -  Generate random num
- http://www.cplusplus.com/forum/general/135491/ - permutations reverse polish notation
- http://www-stone.ch.cam.ac.uk/documentation/rrf/rpn.html - Reverse Polish Notation
- http://www.alcula.com/calculators/rpn/ - Reverse Polish Notation Calculator
- https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket - Code calculator
- https://www.rosettacode.org/wiki/Pick_random_element - pick random element
