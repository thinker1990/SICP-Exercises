#lang racket

;; if b is positive, then a + b, otherwise a - b
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))


;; test cases
(a-plus-abs-b 1 2)   ;; 3
(a-plus-abs-b 1 -2)  ;; 3
