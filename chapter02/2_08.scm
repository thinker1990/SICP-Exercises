#lang sicp

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define (upper-bound interval) 
  (max (car interval) (cdr interval)))


(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y)) 
                 (- (upper-bound x) (lower-bound y))))


;; test cases
(define interval1 (make-interval 2 9))
(define interval2 (make-interval -2 -9))
(define subed (sub-interval interval1 interval2))
(lower-bound subed)  ;; 2 - (-2) = 4
(upper-bound subed)  ;; 9 - (-9) = 18
