#lang sicp

(define (square x) 
  (* x x))

(define (sum-of-squares x y) 
  (+ (square x) 
     (square y)))

(define (sum-of-squares-for-larger-two x y z) 
  (cond ((and (<= x y) (<= x z)) (sum-of-squares y z))
        ((and (<= y x) (<= y z)) (sum-of-squares x z))
        (else (sum-of-squares x y))))


;; test cases
(sum-of-squares-for-larger-two 1 2 3)  ;; 13
(sum-of-squares-for-larger-two 3 2 1)  ;; 13
