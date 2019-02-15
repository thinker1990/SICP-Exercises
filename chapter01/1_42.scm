#lang sicp

(define (compose f g)
    (lambda (x) (f (g x))))

(define (inc x) (+ x 1))

(define (square x) (* x x))


;; test cases
((compose square inc) 6)  ;; 49
