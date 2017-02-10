#lang racket

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


