#lang sicp

(define (square x)
  (* x x))


(define (square-list-low items)
  (if (null? items) 
      nil 
      (cons (square (car items)) (square-list-low (cdr items)))))

(define (square-list-high items)
  (map square items))


;; test cases
(square-list-low (list 1 2 3 4))  ;; (1 4 9 16) 
(square-list-high (list 1 2 3 4))  ;; (1 4 9 16) 
