#lang racket

;; recursive process
(define (f n)
    (cond ((< n 3) n)
        (else (+ (f (- n 1)) 
                 (* 2 (f (- n 2))) 
                 (* 3 (f (- n 3)))))))


;; iterative process
(define (f n)
    (f-iter 2 1 0 n))

(define (f-iter f-n-1 f-n-2 f-n-3 n)
    (cond ((= n 0) f-n-3)
          ((= n 1) f-n-2)
          ((= n 2) f-n-1)
          (else (f-iter (+ f-n-1 (* 2 f-n-2) (* 3 f-n-3)) 
                        f-n-1 
                        f-n-2 
                        (- n 1)))))


;; test cases
(f 0)
(f 1)
(f 2)
(f 3)
(f 4)
(f 5)
(f 7)
(f 10)
(f 13)                       
