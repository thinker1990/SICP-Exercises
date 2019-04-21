#lang sicp

(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

(define (make-frame variables values)
  (map cons variables values))
(define (frame-variables frame) 
  (map car frame))
(define (frame-values frame)
  (map cdr frame))
(define (add-binding-to-frame! var val frame)
  (let ((binding (cons var val)))
    (set! frame (cons binding frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (error "Vars and vals count must match")))

(define (lookup-variable-value var env) 
  (define (env-loop env)
    (define (scan bindings) 
      (if (null? bindings) 
          (env-loop (enclosing-environment env))
          (let ((first (car bindings)))
            (if (eq? var (car first))
                (cdr first)
                (scan (cdr bindings))))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (scan (first-frame env))))
  (env-loop env))

(define (set-variable-value! var val env) 
  (define (env-loop env)
    (define (scan bindings) 
      (if (null? bindings) 
          (env-loop (enclosing-environment env))
          (let ((first (car bindings)))
            (if (eq? var (car first))
                (set-cdr! first val)
                (scan (cdr bindings))))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (scan (first-frame env))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan bindings)
      (if (null? bindings)
          (add-binding-to-frame! var val frame)
          (let ((first (car frame)))
            (if (eq? var (car first))
                (set-cdr! first val)
                (scan (cdr bindings))))))
    (scan frame)))