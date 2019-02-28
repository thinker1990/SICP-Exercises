#lang sicp

(define (last-pair items)
    (if (null? (cdr items)) 
        items 
        (last-pair (cdr items))))


;; test cases
(last-pair (list 23 72 149 34))  ;; (34)
