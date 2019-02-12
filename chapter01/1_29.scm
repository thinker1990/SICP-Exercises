#lang sicp

;; From: https://sicp.readthedocs.io/en/latest/chp1/29.html

(define (inc x)
    (+ x 1))

(define (cube x)
    (* x x x))

(define (sum term next a b) 
    (if (> a b)
        0
        (+ (term a)
           (sum term next (next a) b))))

(define (simpson f a b n)
    (define h (/ (- b a) n))
    (define (factor k)
        (cond ((= k 0) 1)
              ((= k n) 1)
              ((even? k) 2)
              (else 4)))
    (define (y k)
        (f (+ a (* k h))))
    (define (term k)
        (* (factor k) (y k)))
    (* (sum term inc 0 n) 
       (/ h 3.0)))

;; test cases
(simpson cube 0 1 100)
(simpson cube 0 1 1000)
