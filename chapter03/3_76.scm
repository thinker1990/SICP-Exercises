#lang sicp

(define (make-zero-crossings input-stream last-value)
  (define smoothed-stream (smooth input-stream))
  (stream-map 
    sign-change-detector 
    smoothed-stream
    (cons-stream 0 smoothed-stream)))

(define (smooth input-stream) 
  (stream-map 
    average 
    input-stream
    (cons-stream 0 input-stream)))
