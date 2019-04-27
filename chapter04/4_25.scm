#lang sicp

(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))

(factorial 5)
;; this will enter an infinite loop, because in ordinary applicative-order Scheme
;; the parameters will be evaluated first:
;; (* 5 (factorial 4)) -> (* 5 (* 4 (factorial 3))) ... -> (* 5 (* 4 (* 3 (* 2 (factorial 1)))))
;; at this point (factorial 1) will not return 1, instead, it will evaluated to (* 1 (factorial 0)) and so on.

;; If in a normal-order language, this will work as intended.
