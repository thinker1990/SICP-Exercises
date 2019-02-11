#lang sicp

(define (square n)
    (* n n))

(define (expmod base exp mod)
    (cond ((= exp 0) 1)
          ((nontrivial-square-root? base mod) 0)
          ((even? exp) (remainder (square (expmod base (/ exp 2) mod)) 
                                  mod))
          (else (remainder (* base (expmod base (- exp 1) mod)) 
                           mod))))

(define (nontrivial-square-root? a n)
    (and (not (= a 1)) 
         (not (= a (- n 1))) 
         (= 1 (remainder (square a) n))))

(define (Miller-Rabin-test n)
    (define (try-it a) 
        (= (expmod a (- n 1) n) 1))
    (try-it (+ (random (- n 1)) 1)))
     
(define (fast-prime? n times)
    (cond ((= times 0) #t)
          ((Miller-Rabin-test n) (fast-prime? n (- times 1)))
          (else #f)))


;; test cases
;; The smallest Carmichael numbers are 561, 1105, 1729, 2465, 2821, and 6601.
(fast-prime? 561 10)    ;; Carmichael number
(fast-prime? 1105 10)   ;; Carmichael number
(fast-prime? 1729 10)   ;; Carmichael number
(fast-prime? 2465 10)   ;; Carmichael number
(fast-prime? 2821 10)   ;; Carmichael number
(fast-prime? 6601 10)   ;; Carmichael number
(fast-prime? 10000 10)  ;; not prime
(fast-prime? 100000002 10)  ;; not prime
(fast-prime? 100001651 10)  ;; real prime
(fast-prime? 100000937 10)  ;; real prime
