#lang sicp

(define (integral integrand initial-value dt)
  (define int 
          (cons-stream initial-value 
                       (add-stream (scale-stream integrand dt) 
                                   int)))
  int)

(define (RC R C dt) 
  (lambda (v0 i) 
    (add-stream (scale-stream i R) 
                (integral (scale-stream i (/ 1 C)) 
                          v0 
                          dt))))
