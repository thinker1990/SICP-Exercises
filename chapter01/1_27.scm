#lang sicp

(define (square n)
    (* n n))

(define (expmod base exp mod)
    (cond ((= exp 0) 1)
          ((even? exp) (remainder (square (expmod base (/ exp 2) mod)) 
                                  mod))
          (else (remainder (* base (expmod base (- exp 1) mod)) 
                           mod))))

(define (try-it a n) 
    (= (expmod a n n) a))

(define (fermat-test a n)
    (if (= a 1)
         #t
         (and (try-it a n) (fermat-test (- a 1) n))))

(define (fermat-test-all n) 
    (fermat-test (- n 1) n))


;; test cases
;; The smallest Carmichael numbers are 561, 1105, 1729, 2465, 2821, and 6601.
(fermat-test-all 8)
(fermat-test-all 1105)
(fermat-test-all 1729)
(fermat-test-all 2465)
(fermat-test-all 2821)
(fermat-test-all 6601)
