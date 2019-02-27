#lang sicp

(define (make-interval a b)
  (cons a b))

(define (lower-bound x)
  (min (car x) (cdr x)))

(define (upper-bound x) 
  (max (car x) (cdr x)))


(define (make-center-percent c p) 
  (let ((w (/ (* c p) 100.0)))
    (make-interval (- c w) (+ c w))))

(define (center i) 
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i) 
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i) 
  (* (/ (width i) (center i)) 100))


;; test cases
(define percent-i (make-center-percent 100 5))
(lower-bound percent-i)  ;; 95
(upper-bound percent-i)  ;; 105
(center percent-i)  ;; 100
(percent percent-i)  ;; 5
