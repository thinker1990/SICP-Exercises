#lang sicp

;; 1. 
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop 
              (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? (car vals) '*unassigned*)
                 (error "Try to use unassigned variable: ", var)
                 (car vals)))
            (else (scan (cdr vars) 
                        (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;; 2.
(define (scan-out-defines exps)
  (let* ((definitions (filter definition? exps))
         (internal-variables (map definition-variable definitions))
         (internal-values (map definition-value definitions))
         (procdure-body (filter non-definition? exps))
         (var-initials (map initial-var initial-variables))
         (var-sets (map set-var initial-variables initial-values))
         (let-body (append var-sets procdure-body)))
    (make-let var-initials let-body)))

(define (non-definition? exp)
  (not (definition? exp)))
(define (initial-var var)
  (list var '*unassigned*))
(define (set-var var val)
  (list 'set! var val))
(define (make-let identifiers body)
  (cons 'let (cons identifiers body)))

;; 3.
(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))
;; Install scan-out-defines in make-procedure is better.
;; because it only need to do once.
