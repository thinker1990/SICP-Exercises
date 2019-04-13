#lang sicp

(define (make-zero-crossings input-stream last-value last-avg)
  (let ((avpt (average (stream-car input-stream) 
                       last-value)))
    (cons-stream 
      (sign-change-detector avpt last-avg) 
      (make-zero-crossings 
        (stream-cdr input-stream) 
        (stream-car input-stream)
        avpt))))
