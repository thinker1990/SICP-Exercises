#lang sicp

(define (cont-frac n d k x)
    (define (cont-frac-helper count) 
        (if (= count k) 
            (/ (n count x) (d count)) 
            (/ (n count x) (+ (d count) (cont-frac-helper (inc count))))))
    (cont-frac-helper 1))

(define (inc x) (+ x 1))

(define (n i x) 
    (if (= i 1)
        x
        (* x x)))

(define (d i) (- (* i 2) 1.0))


(define (tan-cf x k) 
    (cont-frac n d k x))

;; test cases
(define k 20)
(tan-cf 10 k)
(tan-cf 3.14 k)
