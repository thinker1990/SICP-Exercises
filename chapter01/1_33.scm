#lang sicp

(define (identity x) x)

(define (inc x) (+ x 1))

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

(define (square n) (* n n))

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(define (filtered-accumulate predicate combiner null-value term a next b) 
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) 
                  (if (predicate a) 
                      (combiner (term a) result)
                      result))))
    (iter a null-value))

;; a - the sum of the squares of the prime numbers in the interval a to b.
(define (sum-of-prime a b)
    (filtered-accumulate prime? + 0 identity a inc b))

;; b - the product of all the positive integers less than n that are relatively prime to n.
(define (product-of-prime n)
    (define (relatively-prime? x)
        (= (gcd x n) 1))
    (filtered-accumulate relatively-prime? * 1 identity 1 inc n))


;; test cases
(sum-of-prime 2 10)
(sum-of-prime 4 20)
(product-of-prime 7)
(product-of-prime 12)
