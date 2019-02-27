#lang sicp

(define (make-interval a b)
  (cons a b))

(define (lower-bound x)
  (min (car x) (cdr x)))

(define (upper-bound x) 
  (max (car x) (cdr x)))

(define (width-interval x)
  (/ (- (upper-bound x) (lower-bound x)) 2))


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


;; Show that the width of the sum (or difference) of two intervals 
;; is a function only of the widths of the intervals being added (or subtracted)
;; 
;; (width-interval (add-interval x y)) -> 
;; (/ (- (upper-bound (add-interval x y)) (lower-bound (add-interval x y))) 2) -> 
;; (/ (- (+ (upper-bound x) (upper-bound y)) (+ (lower-bound x) (lower-bound y))) 2) -> 
;; (/ (+ (- (upper-bound x) (lower-bound x)) (- (upper-bound y) (lower-bound y))) 2) -> 
;; (+ (/ (- (upper-bound x) (lower-bound x)) 2) (/ (- (upper-bound y) (lower-bound y)) 2)) -> 
;; (+ (width-interval x) (width-interval y))  
;; 
;; (width-interval (sub-interval x y)) -> 
;; (/ (- (upper-bound (sub-interval x y)) (lower-bound (sub-interval x y))) 2) -> 
;; (/ (- (- (upper-bound x) (lower-bound y)) (- (lower-bound x) (upper-bound y))) 2) -> 
;; (/ (+ (- (upper-bound x) (lower-bound x)) (- (upper-bound y) (lower-bound y))) 2) -> 
;; (+ (/ (- (upper-bound x) (lower-bound x)) 2) (/ (- (upper-bound y) (lower-bound y)) 2)) -> 
;; (+ (width-interval x) (width-interval y))  
;;
;; Give examples to show that this is not true for multiplication or division.
(define x (make-interval 2 4))
(define y (make-interval 3 5))
(define mul-x-y (mul-interval x y))
(define div-x-y (div-interval x y))
(not (= (width-interval mul-x-y) (* (width-interval x) (width-interval y))))  ;; #t
(not (= (width-interval div-x-y) (/ (width-interval x) (width-interval y))))  ;; #t
