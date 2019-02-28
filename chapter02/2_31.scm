#lang sicp

(define (square x)
  (* x x))

(define (tree-map f tree)
  (cond ((null? tree) tree)
        ((pair? (car tree)) (cons (tree-map f (car tree)) (tree-map f (cdr tree))))
        (else (cons (f (car tree)) (tree-map f (cdr tree))))))

(define (square-tree tree) 
  (tree-map square tree))

  
;; test cases
(square-tree
  (list 1
    (list 2 (list 3 4) 5)
    (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))
