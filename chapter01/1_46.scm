#lang sicp

(define (iterative-improve good-enough? improve-guess) 
    (lambda (guess) (if (good-enough? guess)
                        guess
                        ((iterative-improve good-enough? improve-guess) 
                         (improve-guess guess)))))

(define tolerance 0.00001)

(define (sqrt x) 
    (define (square x) (* x x))
    (define (average x y) (/ (+ x y) 2))
    ((iterative-improve 
        (lambda (guess) (< (abs (- (square guess) x)) tolerance))
        (lambda (guess) (average guess (/ x guess)))) 
     1.0))

(define (fixed-point f first-guess) 
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    ((iterative-improve 
        (lambda (guess) (close-enough? guess (f guess))) 
        (lambda (guess) (f guess))) 
     first-guess))


;; test cases
(sqrt 4)
(sqrt 9)
(fixed-point cos 1.0)
(fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)
