#lang sicp

(define (for-each f items)
  (if (null? items)
      #t
      ((lambda (i lst) 
        (f i)
        (for-each f lst)) (car items) (cdr items))))


;; test cases
(for-each (lambda (x)
            (newline)
            (display x))
          (list 57 321 88))
