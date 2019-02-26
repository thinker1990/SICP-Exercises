#lang sicp

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define (upper-bound interval) 
  (max (car interval) (cdr interval)))


;; test cases
(define interval (make-interval 2 9))
(lower-bound interval)  ;; 2
(upper-bound interval)  ;; 9
