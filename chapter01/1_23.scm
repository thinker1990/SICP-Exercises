#lang sicp

(define (prime? n)
    (= (smallest-divisor n) n))

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divisor? test-divisor n) test-divisor)
          (else (find-divisor n (next-odd test-divisor)))))

(define (divisor? tester n)
    (= (remainder n tester) 0))

(define (square n)
    (* n n))

(define (next-odd n)
    (if (even? n)
        (+ n 1)
        (+ n 2)))


(define (start-prime-test start-from count start-time)
    (if (> count 0)
        (if (prime? start-from)
            (report-prime-and-continue-test start-from count start-time)
            (start-prime-test (next-odd start-from) count start-time))
        (report-search-time start-time)))

(define (report-prime-and-continue-test prime count start-time)
    (newline)
    (display prime)
    (start-prime-test (next-odd prime) (- count 1) start-time))

(define (report-search-time start-time)
    (newline)
    (display "Time elapsed: ")
    (display (- (runtime) start-time)))

(define (search-for-primes from count)
    (start-prime-test from count (runtime)))


;; test cases
(search-for-primes 2 3)
(search-for-primes 1000 3)
(search-for-primes 10000 3) 
(search-for-primes 100000 3) 
