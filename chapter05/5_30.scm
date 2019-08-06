;; Solution from: http://community.schemewiki.org/?sicp-ex-5.30

;; if the variable is unbounded, cons 'unbound with it;  
;; otherwise, cons 'bounded with it. then we can use 
;; car to judge it's bounded or not. 
(define (lookup-variable-value var env) 
  (define (env-loop env) 
    (define (scan vars vals) 
      (cond ((null? vars) 
             (env-loop (enclosing-environment env))) 
            ((eq? var (car vars)) 
             (cons 'bounded (car vals)))                 ;; add
            (else (scan (cdr vars) (cdr vals))))) 
    (if (eq? env the-empty-environment) 
            (cons 'unbounded '())                        ;; add 
        (let ((frame (first-frame env))) 
          (scan (frame-variables frame) 
                (frame-values frame))))) 
  (env-loop env)) 
(define (bound-variable? var) 
 (and (pair? var) (eq? (car var) 'bounded))) 
(define (extract-variable-value var) 
 (cdr var)) 
 
ev-variable 
  (assign val (op lookup-variable-value) (reg exp) (reg env)) 
  (test (op bound-variable?) (reg val)) 
  (branch (label bound-variable)) 
  (assign val (const unbounded-variable-error)) 
  (goto (label signal-error))  
bound-variable 
  (assign val (op extract-variable-value) (reg val)) 
  (goto (reg continue)) 
