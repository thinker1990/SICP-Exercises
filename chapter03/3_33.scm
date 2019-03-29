#lang sicp

;; use (a + b) / 2 = c  ->  a + b = 2 * c
(define (average a b c)
  (let ((two (make-connector))
        (sum (make-connector)))
    (adder a b sum)
    (multiplier two c sum)
    (constant 2 two)
    'ok))
