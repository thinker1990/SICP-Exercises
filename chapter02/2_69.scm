#lang racket

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left)
                (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

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
(define manual-tree
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree 
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

(define pairs '((A 4) (B 2) (C 1) (D 1)))
(define generate-tree (generate-huffman-tree pairs))

(equal? manual-tree generate-tree)  ;; #t
