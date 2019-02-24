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


(define (make-rect top-left-point length width) 
  (cons top-left-point (cons length width)))
      
(define (point-rect rect)
  (car rect))

(define (length-rect rect)
  (car (cdr rect)))

(define (width-rect rect)
  (cdr (cdr rect)))

(define (perimeter-rect rect)
  (* (+ (length-rect rect) (width-rect rect)) 2))

(define (area-rect rect)
  (* (length-rect rect) (width-rect rect)))


;; test cases
(define top-left-point (make-point 5 5))
(define rect (make-rect top-left-point 3 4))
(perimeter-rect rect)
(area-rect rect)
