#lang sicp

(define (partial-sums s)
  (con-stream (stream-car s) 
              (add-stream (partial-sums s) 
                          (stream-cdr s))))
