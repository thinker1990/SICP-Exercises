#lang sicp

(define (squarer a b) (multiplier a a b))

;; the connect procedure is defined as:
(define (connect new-constraint)
  (if (not (memq new-constraint 
                 constraints))
      (set! constraints
            (cons new-constraint 
                  constraints)))
  (if (has-value? me)
      (inform-about-value new-constraint))
  'done)

;; the multiplier try to connect (a a b) to inner connector me,
;; but after connect first a to me, the second a can't be connect to me,
;; because a is already in me's contraint list.
;; the consequence is if we set-value of b, the value of a can't be computed.
;;
;; a more elaborate answer from: https://sicp.readthedocs.io/en/latest/chp3/34.html
