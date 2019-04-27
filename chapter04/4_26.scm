#lang sicp

;; 1. unless could be a derived expression of if:
;;    (define (unless condition usual-value exceptional-value)
;;      (if condition exceptional-value usual-value))

(define (unless->if exp)
  (make-if (cadr exp) (cadddr exp) (caddr exp)))

;; Answer from: http://community.schemewiki.org/?sicp-ex-4.26
;; 2. unless as procedure, one may do:
;; (define select-y '(#t #f #t #t)) 
;; (define xs '(1 3 5 7)) 
;; (define ys '(2 4 6 8)) 
;; (define selected (map unless select-y xs ys)) 
