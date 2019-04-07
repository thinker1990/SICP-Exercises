#lang sicp

(define s (cons-stream 1 (add-streams s s)))

;; 1 2 4 8 16 ... 2^n
;; same as:
(define double (cons-stream 1 (scale-stream double 2)))
