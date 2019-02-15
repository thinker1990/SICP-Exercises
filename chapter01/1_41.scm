#lang sicp

(define (double f)
    (lambda (x) (f (f x))))

(define (inc x) (+ x 1))


;; test cases
((double inc) 5)  ;; 7
(((double (double double)) inc) 5)  ;; 21
