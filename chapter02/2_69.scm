#lang racket
(provide (all-defined-out))

(require "2_67.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (make-leaf-set pairs)
  (if (null? pairs) 
      '() 
      (let ((pair (car pairs)))
        (adjoin-set 
          (make-leaf (car pair)
                     (cadr pair))
          (make-leaf-set (cdr pairs))))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) 
         (cons x set))
        (else 
         (cons (car set)
               (adjoin-set x (cdr set))))))
               

(define (successive-merge leafs)
  (cond ((null? leafs) '())
        ((null? (cdr leafs)) (car leafs))
        (else 
          (successive-merge 
            (adjoin-set 
              (make-code-tree (car leafs) (cadr leafs)) 
              (cddr leafs))))))


;; test cases
(define pairs '((A 4) (B 2) (C 1) (D 1)))
(define generate-tree (generate-huffman-tree pairs))

(equal? sample-tree generate-tree)  ;; #t
