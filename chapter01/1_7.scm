#lang racket

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? (improve guess x) guess)
      (improve guess x)
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? new-guess old-guess)
  (< (abs (/ (- new-guess old-guess) old-guess)) 0.001))

(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        (else (- x))))

(define (square x)
  (* x x))


;; test cases
(sqrt 0.0000000000000000001)  ;; small number
(sqrt 100000000000000011111)  ;; large number