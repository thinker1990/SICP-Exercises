#lang sicp

(define (mul-streams s1 s2) (stream-map * s1 s2))

(define factorials
  (cons-stream 1 
               (mul-streams (cdr integers) 
                            factorials)))
;; 1 2 6 24 ... (n+1)!
