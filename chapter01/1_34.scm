#lang sicp

(define (f g) (g 2))


;; test cases
(f f)

;; The interpreter execute to error:
;; 
;; application: not a procedure;
;;  expected a procedure that can be applied to arguments
;;   given: 2
;; 
;; Let's analyze the evaluation of (f f) using application-order: 
;; (f f) -> (f (lambda (g) (g 2)))
;;       -> ((lambda (g) (g 2)) (lambda (g) (g 2)))
;;       -> ((lambda (g) (g 2)) 2)
;;       -> (2 2)
;; 
;; (2 2) is not a legal expression.
