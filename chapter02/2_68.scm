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

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree) 
              (encode (cdr message) tree))))

(define (encode-symbol symbol current-branch)
  (cond ((null? current-branch) '())
        ((not (memq symbol (symbols current-branch))) 
         (error "invalid symbol: " symbol))
        ((leaf? current-branch) '())
        (else 
          (let ((left-sub-branch (left-branch current-branch))
                (right-sub-branch (right-branch current-branch)))
            (if (memq symbol (symbols left-sub-branch)) 
                (cons 0 (encode-symbol symbol left-sub-branch))
                (cons 1 (encode-symbol symbol right-sub-branch)))))))


;; test cases
(define sample-tree
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree 
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

(define sample-message 
  '(A D A B B C A))

(encode sample-message sample-tree)  ;; '(0 1 1 0 0 1 0 1 0 1 1 1 0)
