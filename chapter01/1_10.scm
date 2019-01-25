#lang sicp

(define (A x y)
    (cond ((= y 0) 0)
          ((= x 0) (* 2 y))
          ((= y 1) 2)
          (else (A (- x 1) (A x (- y 1))))))

(A 1 10)  ;; 1024
(A 2 4)   ;; 65536
(A 3 3)   ;; 65536


(define (f n) (A 0 n))  ;; 2 * n
;; test cases
(f 2)
(f 11)
(f 123)

(define (g n) (A 1 n))  ;; 2 ** n
;; test cases
(g 1)
(g 4)
(g 10)

(define (h n) (A 2 n))  ;; 2 ** (h (- n 1))
;; test cases
(h 1)
(h 2)
(h 4)

(define (k n) (* 5 n n)) ;; 5 * n**2
;; test cases
(k 2)
(k 11)
(k 123)
