#lang sicp

(define (invert-unit-series s)
  (define inverted-series 
    (cons-stream 
      1 
      (scale-stream 
        -1 
        (mul-series (stream-cdr s) 
                    inverted-series))))
  inverted-series)
