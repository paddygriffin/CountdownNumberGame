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
(define start(list -1 -1 -1 -1 1 1 1 1 1))

;This line creates all permutations and it removes the duplicates 
(define perms (remove-duplicates (permutations start)))

;This function adds the two 1s to the front of the list and the -1 to the end of the list 
;(define (to-rpn l)
; (append (list 1 1) l (list -1)))
;(to-rpn (car  perms))
;(map to-rpn perms)

;Apply function to every element of the list to get valid RPN
;s= stack to see how many on it
;e= list
(define (valid-rpn? e (s 0)) ;default value is 0
  (if (null? e)
      (if (= s 1) #t #f)
      (if (= (car e) 1)
          (valid-rpn? (cdr e) (+ s 1))
      (if (> s 1)
          (valid-rpn? (cdr e) (- s 1))
          (#f))))) ;true ot false

;Calculate RPN adapted from https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket
(define (calculate-rpn expr)
  (for/fold ([stack '()]) ([token expr])
    (printf "~a\t -> ~a~N" token stack)
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (cons (- y x) s)]
     [('* (list x y s ___)) (cons (* x y) s)]
     [('/ (list x y s ___)) (cons (/ y x) s)]
     [(x s) (error "calculate-RPN: Cannot calculate the expression:" 
                   (reverse (cons x s)))])))



(define nos (list 100 50 10 6 5 1))
(permutations nos)
(define ops (list '+ '- '/ '*))
(cartesian-product ops ops ops ops ops);groups operators
#|

;Function to make a perm into a rpn expression and calculates the expression if valid rpn
(define (to-rpn l)
  (if(valid-rpn? (append nos l ops))
     (calculate-rpn(nos l ops))
    #f)
  )
  
|#



