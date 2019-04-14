#lang sicp

(define (RLC R L C dt)
  (lambda (vC0 iL0) 
    ((define vC (integral (delay dvC) vC0 dt))
     (define iL (integral (delay diL) iL0 dt))
     (define dvC (scale-stream iL (/ -1 C)))
     (define diL 
       (add-stream (scale-stream vC (/ 1 L)) 
                   (scale-stream iL (/ (- R) L))))
                   
     (stream-map (lambda (v i) (cons v i)) 
                 vC 
                 iL))))
