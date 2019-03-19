#lang racket

(define (make-f init)
  (lambda (x) 
    (begin 
      (if (= init 1) (set! init x) #t)
      init)))

(define f-1 (make-f 1))
(define f-2 (make-f 1))


;; test cases
(f-1 0)  ;; 0
(f-1 1)  ;; 0

(f-2 1)  ;; 1
(f-2 0)  ;; 0
