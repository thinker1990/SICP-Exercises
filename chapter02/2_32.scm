#lang sicp

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest 
                (map (lambda (x) (cons (car s) x)) rest)))))  


;; test cases
(define set (list 1 2 3))
(subsets set)

;; a clear explanation of why it works: http://community.schemewiki.org/?sicp-ex-2.32
