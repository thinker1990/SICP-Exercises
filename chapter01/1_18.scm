#lang sicp

(define (fast-multi a b)
    (multi-iter a b 0))

(define (multi-iter a b acc)
    (cond ((= b 0) acc)
          ((even? b) (multi-iter (double a) 
                                 (halve b) 
                                 acc))
          (else (multi-iter a 
                            (- b 1) 
                            (+ a acc)))))

(define (double x)
    (* x 2))

(define (halve x)
    (/ x 2))

(define (even? x)
    (= (remainder x 2) 0))


;; test cases
(fast-multi 2 3)
(fast-multi 4 4)
(fast-multi 4 5)
(fast-multi 4 6)
(fast-multi 4 7)
(fast-multi 4 9)
(fast-multi 4 100)
