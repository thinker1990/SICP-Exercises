#lang sicp

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))


(define (list-of-values-left-to-right exps env)
  (if (no-operands? exps)
      '()
      (let ((left-most (eval (first-operand exps) env)))
        (cons left-most 
              (list-of-values (rest-operands exps) env)))))

(define (list-of-value-right-to-left exps env)
  (define (iter left right)
    (if (no-operands? (rest-operands right))
        (let ((right-most (eval (first-operand right) env)))
          (append (list-of-value-right-to-left left env) (list right-most)))
        (iter (append left (list (first-operand right))) (rest-operands right))))
  (if (no-operands? exps)
      '()
      (iter '() exps)))

;; A more clever way to force eval order is using nested let clause.
;; See: http://community.schemewiki.org/?sicp-ex-4.1
