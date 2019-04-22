#lang sicp

(define (scan bindings var on-match on-mismatch)
  (if (null? bindings)
      (on-mismatch)
      (let ((first (car bindings)))
        (if (eq? var (car first))
            (on-match first)
            (scan (cdr bindings) var on-match on-mismatch)))))


(define (lookup-variable-value var env) 
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (scan (first-frame env)
              var
              (lambda (matched) (cdr matched))
              (lambda () (env-loop (enclosing-environment env))))))
  (env-loop env))

(define (set-variable-value! var val env) 
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (scan (first-frame env)
              var
              (lambda (matched) (set-cdr! matched val))
              (lambda () (env-loop (enclosing-environment env))))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (scan frame
          var
          (lambda (matched) (set-cdr! matched val))
          (lambda () (add-binding-to-frame! var val frame)))))
