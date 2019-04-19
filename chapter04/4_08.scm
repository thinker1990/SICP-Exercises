#lang sicp

;; (let ⟨var⟩ ⟨bindings⟩ ⟨body⟩)

(define (let? exp) 
  (tagged-list? exp 'let))
(define (named-let? let-exp)
  (symbol? (cadr let-exp)))
(define (let-var exp)
  (cadr exp))
(define (let-bindings exp) 
  (if (named-let? exp)
      (caddr exp)
      (cadr exp)))
(define (let-body exp) 
  (if (named-let? exp)
      (cdddr exp)
      (cddr exp)))

(define (bindings-vars bindings)
  (map car bindings))
(define (bindings-exps bindings)
  (map cdr bindings))


(define (let->combination exp)
  (let ((bindings (let-bindings exp))
        (body (let-body exp)))
    (if (named-let? exp)
        (sequence->exp
          (list 
            (make-define 
              (let-var exp) 
              (make-lambda (bindings-vars bindings) body))
            (cons (let-var exp) (bindings-exps bindings))))
        (cons (make-lambda (bindings-vars bindings) body) 
              (bindings-exps bindings)))))

(define (make-define var value)
  (list 'define var value))
