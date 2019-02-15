#lang sicp

(define tolerance 0.00001)
(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess))) 
             (if (close-enough? guess next) 
                 next 
                 (try next))))
    (try first-guess))

(define (average-damp f)
    (lambda (x) (average x (f x))))

(define (average x y)
    (/ (+ x y) 2))

(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f n) 
    (if (= n 1) 
        f 
        (compose f (repeated f (- n 1)))))

(define (square x)
    (* x x))


(define (sqrt x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 
                 1.0))

(define (cube-root x)
    (fixed-point (average-damp (lambda (y) (/ x (square y)))) 
                 1.0))

(define (fourth-root x) 
    (fixed-point ((repeated average-damp 2) 
                  (lambda (y) (/ x (* y y y)))) 
                 1.0))

(define (fifth-root x) 
    (fixed-point ((repeated average-damp 2) 
                  (lambda (y) (/ x (* (square y) (square y))))) 
                 1.0))

(define (n-th-root x n) 
    (fixed-point ((repeated average-damp (floor (sqrt n))) 
                  (lambda (y) (/ x ((repeated (lambda (t) (* y t)) (- n 2)) y)))) 
                 1.0))


;; test cases
(sqrt 4)
(sqrt 9)
(cube-root 8)
(cube-root 27)
(fourth-root 16)
(fourth-root 81)
(fifth-root 32)
(fifth-root 243)
(n-th-root 8 3)
(n-th-root 27 3)
(n-th-root 16 4)
(n-th-root 81 4)
(n-th-root 32 5)
(n-th-root 243 5)
(n-th-root 64 6)
(n-th-root 729 6)
(n-th-root 128 7)
(n-th-root 2187 7)

;; A better solution: https://sicp.readthedocs.io/en/latest/chp1/45.html
