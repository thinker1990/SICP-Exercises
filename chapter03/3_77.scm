#lang sicp

(define (integral integrand-delayed initial-value dt)
  (cons-stream 
    initial-value
    (let ((integrand (force integrand-delayed)))
      (if (stream-null? integrand)
          the-empty-stream
          (integral (delay (stream-cdr integrand))
                    (+ (* dt (stream-car integrand)) 
                       initial-value)
                    dt)))))
