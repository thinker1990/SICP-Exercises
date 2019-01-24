#lang racket

(define (fast-multi a b)
    (cond ((= b 1) a)
          ((even? b) (double (fast-multi a (halve b))))
          (else (+ a (fast-multi a (- b 1))))))

(define (double x)
    (* x 2))

(define (halve x)
    (/ x 2))

(define (even? x)
    (= (remainder x 2) 0))


;; test cases
(fast-multi 2 3)
(fast-multi 4 4)
(fast-multi 4 5)
(fast-multi 4 6)
(fast-multi 4 7)
(fast-multi 4 9)
(fast-multi 4 100)
