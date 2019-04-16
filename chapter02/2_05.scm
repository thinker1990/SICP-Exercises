#lang sicp

(define (power base exp) 
  (if (= exp 0) 
      1 
      (* (power base (- exp 1)) base)))

(define (extract-exp n base exp) 
  (if (= (remainder n base) 0) 
      (extract-exp (/ n base) base (+ exp 1)) 
      exp))

(define (cons a b) 
  (* (power 2 a) (power 3 b)))

(define (car pair)
  (extract-exp pair 2 0))

(define (cdr pair)
  (extract-exp pair 3 0))


;; test cases
(define pair (cons 3 4))
(car pair)  ;; 3
(cdr pair)  ;; 4
