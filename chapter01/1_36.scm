#lang sicp

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess))) 
             (newline)
             (display guess)
             (if (close-enough? guess next) 
                 next 
                 (try next))))
    (try first-guess))

;; Find a solution to x^x = 1000 by finding a fixed point of x |→ log(1000)/log(x)
(define (average a b)
    (/ (+ a b) 2))

(define (f x) 
    (/ (log 1000) (log x)))

(display "Without average damping:")

(define x-without-average-damping 
    (fixed-point f 2.0))

(newline)
(display x-without-average-damping)
(newline)
(newline)
(display "With average damping:")

(define x-with-average-damping 
    (fixed-point (lambda (x) (average (f x) x)) 
                 2.0))

(newline)
(display x-with-average-damping)
