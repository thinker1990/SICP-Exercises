#lang sicp

(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f n) 
    (if (= n 1) 
        f 
        (compose f (repeated f (- n 1)))))

(define (square x) (* x x))

(define dx 0.00001)
(define (smooth f)
    (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

;; test cases
((repeated (smooth square) 2) 5)  ;; ~ 625
