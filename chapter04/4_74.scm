#lang sicp

;; a. 
(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-flatten stream)
  (stream-map stream-car
    (stream-filter 
      (lambda (frame) 
        (not (stream-null? frame))) 
      stream)))

;; b. 
;; There is no difference in behaviour (as long as Alyssa’s assertions are correct.)
