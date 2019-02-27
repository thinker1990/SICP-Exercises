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


;; there is a simple formula for the approximate percentage tolerance of the product 
;; of two intervals in terms of the tolerances of the factors.
;; 
;; i1 : c1 * (1 - p1), c1 * (1 + p1)  
;; i2 : c2 * (1 - p2), c2 * (1 + p2) 
;; i1 * i2 :  c1 * (1 - p1) * c2 * (1 - p2), c1 * (1 + p1) * c2 * (1 + p2) -> 
;;            c1 * c2 * (1 - p1 - p2 + p1 * p2), c1 * c2 * (1 + p1 + p2 + p1 * p2) 
;; 
;; p1 * p2 is very small, and we can ignore it. we get:
;; i1 * i2 :  c1 * c2 * (1 - (p1 + p2)), c1 * c2 * (1 + (p1 + p2)) 
;; 
;; so, the approximate percentage tolerance of the product is the sum of the tolerances of the factors.

(define (mul-interval x y)
  (make-center-percent (* (center x) (center y)) 
                       (+ (percent x) (percent y))))
