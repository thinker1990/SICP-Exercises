#lang sicp

(define (fringe tree)
  (cond ((null? tree) tree)
        ((not (pair? (car tree))) (cons (car tree) (fringe (cdr tree))))
        (else (append (fringe (car tree)) (fringe (cdr tree))))))
      

;; test cases
(define x (list (list 1 2) (list 3 4)))
(fringe x)  ;; (1 2 3 4)
(fringe (list x x))  ;; (1 2 3 4 1 2 3 4)
