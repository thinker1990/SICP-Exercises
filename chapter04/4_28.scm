#lang sicp

;; Answer from: http://community.schemewiki.org/?sicp-ex-4.28
;; When an operator is passed as argument to a high order procedure, for example: 
(define (g x) (+ x 1)) 
(define (f g x) (g x)) 
  
;; When call (f g 10), if don't use actual-value which will call force-it, 
;; g will be passed as parameter which will be delayed, then g is a thunk, can't be used as function to call 10. 
