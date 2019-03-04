#lang racket

(define (equal? items1 items2)
    (cond ((not (pair? items1)) (eq? items1 items2))
          ((null? items1) (null? items2))
          (else (and (equal? (car items1) (car items2)) 
                     (equal? (cdr items1) (cdr items2))))))


;; test cases
(equal? 'a 'a)  ;; #t
(equal? 'a 'b)  ;; #f
(equal? '(this is a list) '(this is a list))  ;; #t
(equal? '(this is a list) '(this (is a) list))  ;; #f
