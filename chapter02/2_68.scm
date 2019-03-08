#lang racket
(provide (all-defined-out))

(require "2_67.scm")

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
(define message '(A D A B B C A))

(encode message sample-tree)  ;; '(0 1 1 0 0 1 0 1 0 1 1 1 0)
