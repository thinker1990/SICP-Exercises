#lang sicp

(define (make-interval a b)
  (cons a b))

(define (lower-bound x)
  (min (car x) (cdr x)))

(define (upper-bound x) 
  (max (car x) (cdr x)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y)) 
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y)) 
                 (- (upper-bound x) (lower-bound y))))
        
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval
    x
    (make-interval (/ 1.0 (upper-bound y))
                   (/ 1.0 (lower-bound y)))))


(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
      one 
      (add-interval (div-interval one r1)
                    (div-interval one r2)))))


;; Demonstrate that Lem is right.
(define A (make-interval 499 501)) 
(define B (make-interval 599 601))
(define p1 (par1 A B))
(define p2 (par2 A B))
(equal? (lower-bound p1) (lower-bound p2))  ;; #f
(equal? (upper-bound p1) (upper-bound p2))  ;; #f

;; Examine the results of the computation in center-percent form
(define (make-center-percent c p) 
  (let ((w (/ (* c p) 100.0)))
    (make-interval (- c w) (+ c w))))

(define (center i) 
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i) 
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i) 
  (* (/ (width i) (center i)) 100))

(define A1 (make-center-percent 500 1))
(define B1 (make-center-percent 600 1))
(define p3 (par1 A1 B1))
(define p4 (par2 A1 B1))
(equal? (center p3) (center p4))    ;; #f
(equal? (percent p3) (percent p4))  ;; #f
