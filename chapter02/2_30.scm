#lang sicp

(define (square x)
  (* x x))


(define (square-tree-1 tree)
  (cond ((null? tree) tree)
        ((pair? (car tree)) (cons (square-tree-1 (car tree)) (square-tree-1 (cdr tree))))
        (else (cons (square (car tree)) (square-tree-1 (cdr tree))))))
        
(define (square-tree-2 tree)
  (map 
    (lambda (x) 
      (if (pair? x)
          (square-tree-2 x)
          (square x))) 
    tree))

  
;; test cases
(square-tree-1
  (list 1
    (list 2 (list 3 4) 5)
    (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))

(square-tree-2
  (list 1
    (list 2 (list 3 4) 5)
    (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))
