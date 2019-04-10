#lang sicp

(define (sqrt-stream x)
  (cons-stream 1.0 
    (stream-map
      (lambda (guess)
        (sqrt-improve guess x))
      (sqrt-stream x))))

;; An elaborate answer from: https://sicp.readthedocs.io/en/latest/chp3/63.html
