#lang sicp

(define (inc x)
    (+ x 1))

(define (cube x)
    (* x x x))

(define (sum term a next b) 
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (+ (term a) result))))
    (iter a 0))


;; test cases
(sum cube 1 inc 3)
(sum cube 2 inc 4)
