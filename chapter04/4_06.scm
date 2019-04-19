#lang sicp

;; (let ((⟨var₁⟩ ⟨exp₁⟩) … (⟨varₙ⟩ ⟨expₙ⟩))
;;   ⟨body⟩)
;; is equivalent to
;; 
;; ((lambda (⟨var₁⟩ … ⟨varₙ⟩)
;;    ⟨body⟩)
;;  ⟨exp₁⟩
;;  …
;;  ⟨expₙ⟩)

(define (eval exp env)
  (cond ((self-evaluating? exp) 
         exp)
        ...
        ((let? exp)
         (eval (let->combination exp) env))
        ...
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values 
                 (operands exp) 
                 env)))
        (else
         (error "Unknown expression 
                 type: EVAL" exp))))



(define (let? exp) 
  (tagged-list? exp 'let))
(define (let-identifiers exp) 
  (cdr exp))
(define (let-body exp) 
  (cddr exp))

(define (identifiers-vars identifiers)
  (map car identifiers))
(define (identifiers-exps identifiers)
  (map cdr identifiers))

(define (let->combination exp)
  (let ((identifiers (let-identifiers exp))
        (body (let-body exp)))
    (cons (make-lambda (identifiers-vars identifiers) body) 
          (identifiers-exps identifiers))))
