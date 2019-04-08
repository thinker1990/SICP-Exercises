#lang sicp

;; a. 
(define (integrate-series s)
  (stream-map / s integers))

;; b.
(define cosine-series (cons-stream 1 (integrate-series sine-series)))
(define sine-series (cons-stream 0 (stream-map - (integrate-series cosine-series))))
