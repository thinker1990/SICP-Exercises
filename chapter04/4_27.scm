#lang sicp

(define count 0)
(define (id x) (set! count (+ count 1)) x)

(define w (id (id 10)))

;;; L-Eval input:
count

;;; L-Eval value:
1  ;; see: https://wizardbook.wordpress.com/2011/01/05/exercise-4-27/

;;; L-Eval input:
w

;;; L-Eval value:
10  ;; (id (id 10)) -> (id 10) -> 10

;;; L-Eval input:
count

;;; L-Eval value:
2  ;; in order to get value of w, (id x) has bee evaluated twice, 
   ;; so (set! count (+ count 1)) has also been evaluated twice, and count is set to 2
