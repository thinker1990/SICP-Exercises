#lang sicp

(define (eval-quoted exp env)
  (text-of-quotation exp env))

(define (text-of-quotation exp env)
  (let ((quoted (cadr exp)))
    (if (pair? quoted)
        (eval (pair->lazy-list quoted) env)
        quoted)))

(define (pair->lazy-list p)
  (if (null? p)
      (list 'quote '())
      (list 'cons 
            (list 'quote (car p)) 
            (pair->lazy-list (cdr p)))))
