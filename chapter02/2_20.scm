#lang sicp

(define (same-parity x . y)
  (define (append-same-parity lst result) 
    (if (null? lst) 
        result 
        (if (even? (- (car lst) x)) 
            (append-same-parity (cdr lst) (append result (list (car lst)))) 
            (append-same-parity (cdr lst) result))))
  (append-same-parity y (list x)))


;; test cases
(same-parity 1 2 3 4 5 6 7)  ;; (1 3 5 7)
(same-parity 2 3 4 5 6 7)  ;; (2 4 6)
