#lang sicp

(define (prime? n)
    (= (smallest-divisor n) n))

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


(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))


(define (search-for-primes range-from range-to)
    (timed-prime-test range-from)
    (if (< range-from range-to)
        (search-for-primes (+ range-from 2) range-to)))


;; test cases
(search-for-primes 1 1000)
(search-for-primes 1001 10000)
(search-for-primes 10001 100000) 
(search-for-primes 100001 1000000) 
