#lang sicp

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (print-point point)
  (display "(")
  (display (x-point point))
  (display ", ")
  (display (y-point point))
  (display ")"))


(define (make-segment start-point end-point)
  (cons start-point end-point))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (midpoint-segment segment)
  (make-point (average (x-point (start-segment segment)) 
                       (x-point (end-segment segment))) 
              (average (y-point (start-segment segment)) 
                       (y-point (end-segment segment)))))

(define (average x y)
  (/ (+ x y) 2))
                       

;; test cases
(define point1 (make-point 0 0))
(define point2 (make-point 4 6))
(define segment (make-segment point1 point2))
(print-point (midpoint-segment segment))
