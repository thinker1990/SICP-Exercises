#lang sicp

(define (cube-sum pair) 
  (+ (cube (car pair))
     (cube (cadr pair))))

(define cube-sums 
  (stream-map cube-sum 
              (weighted-pairs integers integers cube-sum)))

(define (consecutive-equal s) 
  (let ((first (stream-car s))
        (second (stream-car (stream-cdr s))))
    (if (eq? first second)
        (cons-stream second 
                     (consecutive-equal (stream-cdr (stream-cdr s)))) 
        (consecutive-equal (stream-cdr (stream-cdr s))))))

(consecutive-equal cube-sums)
