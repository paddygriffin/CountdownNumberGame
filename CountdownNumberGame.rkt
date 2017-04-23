#lang racket
#|
Practice code
;Patrick Griffin G00314635
;Theory of Algorithms Project
;Countdown Number Game

;list of available numbers for the game, can only get 6 of these 
(define listNums (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
;listNums

;generator
(define rand (random 101 1000))
rand

;define a list for the 6 random numbers to go in (an empty list)
(define nums(list))
;nums


;Now we have an empty list we have to fill it with 6 random numbers
;1st- define a function
;2nd- use cons to add onto list
;(define gameNums(n))
;list-ref gets random position value from a list 
;set! saves number
;https://www.rosettacode.org/wiki/Pick_random_element
(define (pick-item l)
  (define r(list-ref l (random (length l))))
(set! nums(cons r nums));adds to empty list
  (set! l (remove r l))
  (if (= (length nums)6)
      nums
      (pick-item l))
  )
(pick-item listNums)
|#

; -1 will represent operators
; 1 will represent numbers. 
(define start(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
(define op (list '+ '+ '+ '+ '+ '- '- '- '- '- '- '* '* '* '* '*  '/ '/ '/ '/ '/))
;Give the outline of numbers
start
;Generate Random Num
(define rand (random 101 1000))
rand

;define a list for the 6 random numbers to go in (an empty list)
(define nums(list))
;nums


;Now we have an empty list we have to fill it with 6 random numbers
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

(define numbers2 (list));Creates list for selecting 4 numbers
(define (listNumbers2 r);Creates list for random numbers  
  (define randomNumber(list-ref r(random (length r))))  
  (set! r(remove randomNumber r)) 
  (set! numbers2 (cons randomNumber numbers2))  
  (if (= (length numbers2) 2)
     numbers2 ;Prints 2 random numbers
      (listNumbers2 r))
)
(listNumbers2 start);Outputs second random list

(define selectOp (list));Creates list for selecting 4 numbers
(define (randomListOp r);Creates list for random numbers  
  (define randomOp(list-ref r(random (length r))))  
  (set! r(remove randomOp r)) 
  (set! selectOp (cons randomOp selectOp))  
  (if (= (length selectOp) 1)
     selectOp ;Prints 2 random numbers
      (randomListOp r))
)
(randomListOp op);Outputs second random list

;Need a function for random operators same as above code except calling operators
(define select4Ops (list));Creates list for selecting 4 operands
(define (randomList r);Creates list  
  (define randomOp(list-ref r(random (length r))))  
  (set! r(remove randomOp r)) 
  (set! select4Ops (cons randomOp select4Ops))  
  (if (= (length select4Ops) 4)
     select4Ops ;Prints 4 random operators
      (randomList r))
)
(randomList op);Outputs second random list

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
          #f)))) ;true ot false

(define resultsList null)



; Reverse Polish Notation function, Sourced from https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket

(define (calculate-RPN expr)
  (for/fold ([stack '()]) ([token expr])
    ;(printf "~a\t -> ~a~N" token stack) ; Uncomment to see workings, not recommended for long lists.
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

;Function to append the numbers with operations
(define (to-rpn l)
  (cond [(valid-rpn? (append numbers2 l selectOp))
   (calculate-RPN (append numbers2 l selectOp))]))

(map to-rpn allPerms)
#|
;This line creates all permutations and it removes the duplicates 
(define perms (remove-duplicates (permutations start)))
;This function adds the two 1s to the front of the list and the -1 to the end of the list 
(define (to-rpn l)
 (append (list 1 1) l (list -1)))
(map to-rpn perms)
;Apply function to every element of the list to get valid RPN
;s= stack to see how many on it
;e= list
(define (valid-rpn? e (s 0)) ;default value is 0
  (if (null? e)
      (if (= s 1) #t #f)
      (if (= (car e) 1)
          (valid-rpn? (cdr e) (+ s 1))
      (if (< s 2)
          #f
          (#t))))) ;true ot false
|#