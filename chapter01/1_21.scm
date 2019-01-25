#lang racket

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divisor? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))

(define (divisor? tester n)
    (= (remainder n tester) 0))

(define (square n)
    (* n n))


;; test cases
(smallest-divisor 199)    ;; 199
(smallest-divisor 1999)   ;; 1999
(smallest-divisor 19999)  ;; 7
