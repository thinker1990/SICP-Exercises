#lang sicp

(define (make-interval a b)
  (cons a b))

(define (lower-bound x)
  (min (car x) (cdr x)))

(define (upper-bound x) 
  (max (car x) (cdr x)))


(define (span-zero? x) 
  (<= (* (lower-bound x) (upper-bound x)) 0))
        
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (span-zero? y)
      (error "Divide by span zero interval")
      (mul-interval
        x
        (make-interval (/ 1.0 (upper-bound y))
                       (/ 1.0 (lower-bound y))))))


;; test cases
(div-interval (make-interval 2 4) (make-interval 3 5))  ;; normal
(div-interval (make-interval 2 4) (make-interval -3 5))  ;; error
