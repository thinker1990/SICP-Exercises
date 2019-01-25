#lang sicp

(define (fast-expt b n) 
    (expt-iter b n 1))

(define (expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (expt-iter (square b)
                                (/ n 2) 
                                a))
          (else (expt-iter b 
                           (- n 1) 
                           (* a b)))))

(define (even? n)
    (= (remainder n 2) 0))

(define (square x)
    (* x x))


;; test cases
(fast-expt 2 3)
(fast-expt 2 4)
(fast-expt 2 5)
(fast-expt 2 6)
(fast-expt 2 7)
(fast-expt 2 10)
