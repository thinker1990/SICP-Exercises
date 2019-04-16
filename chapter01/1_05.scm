#lang sicp

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))


;; test cases
(test 0 (p))
;; applicative-order: the interpreter will enter infinite loop.
;;     Because applicative-order evaluation will evaluate the
;;     arguments first. When encounter the second argument (p),
;;     infinite recursive happens, the interpreter will freeze.
;;
;; normal-order: the interpreter will print result 0 immediately.
;;     Because normal-order evaluation would not evaluate the operands
;;     until their values were needed. When evaluate the if expression,
;;     the predicate part, (= x 0) evaluated to true. the interpreter 
;;     then evaluates the consequent part and returns its value, 0.
;;     The alternative part, (p) is not evaluted at all.
