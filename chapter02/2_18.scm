#lang sicp

(define (reverse lst)
  (if (null? lst)
      lst
      (append (reverse (cdr lst)) (list (car lst)))))


;; test cases
(reverse (list 1 4 9 16 25))  ;; (25 16 9 4 1) 
