#lang sicp

(define (make-interval a b)
  (cons a b))

(define (lower-bound x)
  (min (car x) (cdr x)))

(define (upper-bound x) 
  (max (car x) (cdr x)))


(define (positive? x)
  (> x 0))
        
(define (negative? x)
  (not (positive? x)))

(define (mul-interval x y) 
  (let ((lower-x (lower-bound x))
        (upper-x (upper-bound x))
        (lower-y (lower-bound y))
        (upper-y (upper-bound y)))
    (cond ((and (positive? lower-x) (positive? upper-x) (positive? lower-y) (positive? upper-y)) 
            (make-interval (* lower-x lower-y) (* upper-x upper-y)))
          ((and (negative? lower-x) (positive? upper-x) (positive? lower-y) (positive? upper-y)) 
            (make-interval (* lower-x upper-y) (* upper-x upper-y)))
          ((and (negative? lower-x) (negative? upper-x) (positive? lower-y) (positive? upper-y)) 
            (make-interval (* lower-x upper-y) (* upper-x lower-y)))
          ((and (positive? lower-x) (positive? upper-x) (negative? lower-y) (positive? upper-y)) 
            (make-interval (* upper-x lower-y) (* upper-x upper-y)))
          ((and (positive? lower-x) (positive? upper-x) (negative? lower-y) (negative? upper-y)) 
            (make-interval (* upper-x lower-y) (* lower-x upper-y)))
          ((and (negative? lower-x) (positive? upper-x) (negative? lower-y) (negative? upper-y)) 
            (make-interval (* upper-x lower-y) (* lower-x lower-y)))
          ((and (negative? lower-x) (negative? upper-x) (negative? lower-y) (positive? upper-y)) 
            (make-interval (* lower-x upper-y) (* lower-x lower-y)))
          ((and (negative? lower-x) (negative? upper-x) (negative? lower-y) (negative? upper-y)) 
            (make-interval (* upper-x upper-y) (* lower-x lower-y)))
          (else (let ((p1 (* lower-x upper-y))
                      (p2 (* upper-x lower-y))
                      (p3 (* lower-x lower-y))
                      (p4 (* upper-x upper-y)))
                  (make-interval (min p1 p2) (max p3 p4)))))))


;; test cases
(define x1 (mul-interval (make-interval 2 4) (make-interval 3 5)))
(lower-bound x1)  ;; 2 * 3 = 6
(upper-bound x1)  ;; 4 * 5 = 20 
(define x2 (mul-interval (make-interval -2 4) (make-interval 3 5)))
(lower-bound x2)  ;; -2 * 5 = -10
(upper-bound x2)  ;; 4 * 5 = 20 
(define x3 (mul-interval (make-interval -4 -2) (make-interval 3 5)))
(lower-bound x3)  ;; -4 * 5 = -20
(upper-bound x3)  ;; -2 * 3 = -6 
(define x4 (mul-interval (make-interval 2 4) (make-interval -3 5)))
(lower-bound x4)  ;; 4 * -3 = -12
(upper-bound x4)  ;; 4 * 5 = 20
(define x5 (mul-interval (make-interval 2 4) (make-interval -3 -5)))
(lower-bound x5)  ;; 4 * -5 = -20
(upper-bound x5)  ;; 2 * -3 = -6  
(define x6 (mul-interval (make-interval -2 4) (make-interval -3 -5)))
(lower-bound x6)  ;; 4 * -5 = -20
(upper-bound x6)  ;; -2 * -5 = 10 
(define x7 (mul-interval (make-interval -2 -4) (make-interval -3 5)))
(lower-bound x7)  ;; 4 * -5 = -20
(upper-bound x7)  ;; 4 * -3 = 12 
(define x8 (mul-interval (make-interval -2 -4) (make-interval -3 -5)))
(lower-bound x8)  ;; -2 * -3 = 6
(upper-bound x8)  ;; -4 * -5 = 20
(define x9 (mul-interval (make-interval -2 4) (make-interval -3 5)))
(lower-bound x9)  ;; 4 * -3 = -12
(upper-bound x9)  ;; 4 * 5 = 20
