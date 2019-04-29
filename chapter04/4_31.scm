#lang sicp

(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values 
           arguments 
           env))) 
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           (list-of-mixed-args 
            arguments 
            env)   ; changed
           (procedure-environment procedure))))
        (else (error "Unknown procedure 
                      type: APPLY" 
                     procedure))))


(define (list-of-mixed-args exps env)
  (if (no-operands? exps)
      '()
      (cons (delay-if-lazy 
             (first-operand exps) 
             env)
            (list-of-mixed-args 
             (rest-operands exps)
             env))))

(define (delay-if-lazy exp env)
  (if (lazy? exp)
      (delay-it exp env)
      exp))

(define (lazy? exp)
  (and (pair? exp) 
       (eq? (cadr exp) 'lazy)))
