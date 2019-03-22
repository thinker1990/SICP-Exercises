#lang sicp

(define x (list 'a 'b))
(define z1 (cons x x))

(define z2 
  (cons (list 'a 'b) (list 'a 'b)))

(define (set-to-wow! x)
  (set-car! (car x) 'wow)
  x)


z1  ;; ((a b) a b)
(set-to-wow! z1)  ;; ((wow b) wow b)

z2  ;; ((a b) a b)
(set-to-wow! z2)  ;; ((wow b) a b)

;; An excellent answer with diagram from: https://sicp.readthedocs.io/en/latest/chp3/15.html
