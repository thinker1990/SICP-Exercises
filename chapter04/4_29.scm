#lang sicp

(define count 0)
(define (id x) (set! count (+ count 1)) x)

(define (square x) (* x x))

;;; L-Eval input:
(square (id 10))

;;; L-Eval value:
100  ;; for both memoizes or not

;;; L-Eval input:
count

;;; L-Eval value:
1  ;; for memoizes
2  ;; for non-memoizes

;; A more elaborate answer from: https://wizardbook.wordpress.com/2011/01/06/exercise-4-29/
