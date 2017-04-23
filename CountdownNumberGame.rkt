#lang racket
#|
Practice code
Patrick Griffin G00314635
Theory of Algorithms Project
Countdown Number Game
|#

;List of Nums 
(define start(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
;Generate all permutaions off all operators as 6 numbers so 5 operators
(define op (list '+ '+ '+ '+ '+ '- '- '- '- '- '- '* '* '* '* '*  '/ '/ '/ '/ '/))
;Give the outline of numbers
start
;Generate Random Num
(define rand (random 101 1000))
rand

;define a list for the 6 random numbers to go in (an empty list)
(define nums(list))
;nums


;Now we have an empty list we have to fill it with 4 random numbers then 2 random numbers
;1st- define a function
;2nd- use cons to add onto list
;(define gameNums(n))
;list-ref gets random position value from a list 
;set! saves number
;https://www.rosettacode.org/wiki/Pick_random_element - adapted from

(define numbers4 (list));Creates list for selecting 4 numbers
(define (randomListNumbers l);Creates list for random numbers  
  (define randomNumber(list-ref l(random (length l))))  
  (set! l(remove randomNumber l)) 
  (set! numbers4 (cons randomNumber numbers4))  
  (if (= (length numbers4) 4)
     numbers4 ;Prints 4 random numbers
      (randomListNumbers l))
)
(randomListNumbers start);Outputs random list

(define numbers2 (list));Creates list for selecting 2 numbers
(define (listNumbers2 r);Creates list for random numbers  
  (define randomNumber(list-ref r(random (length r))))  
  (set! r(remove randomNumber r)) 
  (set! numbers2 (cons randomNumber numbers2))  
  (if (= (length numbers2) 2)
     numbers2 ;Prints 2 random numbers
      (listNumbers2 r))
)
(listNumbers2 start);Outputs second random list

;Need a function for random operators same as above code except calling operators
(define selectOp (list));Creates list for selecting 1 operator for the end of the stack
(define (randomListOp r);Creates list  
  (define randomOp(list-ref r(random (length r))))  
  (set! r(remove randomOp r)) 
  (set! selectOp (cons randomOp selectOp))  
  (if (= (length selectOp) 1)
     selectOp ;Prints op
      (randomListOp r))
)
(randomListOp op);Outputs the op


(define select4Ops (list));Creates list for selecting 4 operators
(define (randomList r);Creates list  
  (define randomOp(list-ref r(random (length r))))  
  (set! r(remove randomOp r)) 
  (set! select4Ops (cons randomOp select4Ops))  
  (if (= (length select4Ops) 4)
     select4Ops ;Prints 4 random operators
      (randomList r))
)
(randomList op);Outputs second random list

;Merging lists
(define allPerms(remove-duplicates (permutations (append select4Ops numbers4))))

;Apply function to every element of the list to get valid RPN
;s= stack to see how many on it
;e= list
(define (valid-rpn? e (s 0)) ;default value is 0
  (if (null? e)
      (if (= s 1) #t #f)
      (if (number? (car e) )
          (valid-rpn? (cdr e) (+ s 1))
      (if (> s 1)
          (valid-rpn? (cdr e) (- s 1))
          #f)))) ;true or false

(define resultsList null)



; Reverse Polish Notation function, Sourced from https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket

(define (calculate-RPN expr)
  (for/fold ([stack '()]) ([token expr])
   ; (printf "~a\t -> ~a~N" token stack) ;Uncomment to see the stack
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (cons (- y x) s)]
     [('* (list x y s ___)) (cons (* x y) s)]
     [('/ (list x y s ___)) (if (= y 0)
                                (cons 0 s)
                                (if (= x 0)
                                    (cons 0 s)
                                    (cons (/ x y) s)))]
     [(x s) (error "calculate-RPN: Cannot calculate the expression:" 
                   (reverse (cons x s)))])))

;Function to append the numbers with operations as 2 nums need to be at start and operator at the end
(define (to-rpn l)
  (cond [(valid-rpn? (append numbers2 l selectOp))
   (calculate-RPN (append numbers2 l selectOp))]))

;map passes a list into a function
(map to-rpn allPerms)

; Void output is invalid RPN