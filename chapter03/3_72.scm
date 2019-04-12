#lang sicp

(define (square-sum pair) 
  (+ (square (car pair))
     (square (cadr pair))))

(define square-sums 
        (weighted-pairs integers integers square-sum))

(define (consecutive-3-equal s) 
  (let ((first (stream-car s))
        (second (stream-car (stream-cdr s)))
        (third (stream-car (stream-cdr (stream-cdr s)))))
    (if (and (eq? first second) (eq? second third))
        (cons-stream (list (square-sum first) first second third) 
                     (consecutive-3-equal (stream-cdr (stream-cdr (stream-cdr s))))) 
        (consecutive-3-equal (stream-cdr s)))))

(consecutive-3-equal square-sums)
