#lang sicp

(define (expmod base exp mod)
    (cond ((= exp 0) 1)
          ((even? exp) (remainder (square (expmod base (/ exp 2) mod)) 
                                  mod))
          (else (remainder (* base (expmod base (- exp 1) mod)) 
                           mod))))

(define (fermat-test n)
    (define (try-it a) 
        (= (expmod a n n) a))
    (try-it (+ (random (- n 1)) 1)))

(define (fast-prime? n times)
    (cond ((= times 0) #t)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else #f)))

(define (square n)
    (* n n))

(define (next-odd n)
    (if (even? n)
        (+ n 1)
        (+ n 2)))


(define (start-prime-test start-from count start-time)
    (if (> count 0)
        (if (fast-prime? start-from 10)
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
