#lang sicp

;; a. 
;; After reordering the cond clauses in eval, 
;; the special forms will be treated as ordinary procedure application
;; eg. when evaluate the expression (define x 3)
;; the evaluator will try to apply the 'define operator to parameters (x 3)
;; which is definitely wrong!

;; b.
(define (application? exp)
  (tagged-list? exp 'call))
(define (operator exp)
  (cadr exp))
(define (operands exp)
  (cddr exp))
