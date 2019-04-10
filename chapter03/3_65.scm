#lang sicp

(define (lne-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (lne-summands (+ n 1)))))

(define lne-stream-v1 
  (partial-sums (lne-summands 1)))

(define lne-stream-v2 
  (euler-transform lne-stream-v1))

(deifne lne-stream-v3 
  (accelerated-sequence euler-transform lne-stream-v1))
