#lang sicp

;; a - recursive version
(define (product term a next b) 
    (if (> a b)
        1
        (* (term a)
           (product term (next a) next b))))

;; b - iterative version
(define (product term a next b) 
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* (term a) result))))
    (iter a 1))


(define (inc x) (+ x 1))

(define (identity x) x)

(define (factorial n)
    (product identity 1 inc n))

(define (square x)
    (* x x))

(define (product-pi n)
    (define (term x) 
        (/ (- (square x) 1) (square x)))
    (define (next x)
        (+ x 2))
    (* (product term 3 next n) 4.0))


;; test cases
(factorial 3)
(factorial 5)
(product-pi 99)
(product-pi 999)
