#lang sicp

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))


(define lst1 '(((a))))
(count-pairs lst1)  ;; 3

(define lst2 '((a) (b)))
(count-pairs lst2)  ;; 4

(define lst3 '((a b) (c d e)))
(count-pairs lst3)  ;; 7

(define lst4 (make-cycle '((a b))))
(count-pairs lst4)  ;; never return
