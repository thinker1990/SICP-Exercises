#lang sicp

(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))

(define (cdr z) 
  (z (lambda (p q) q)))


;; test cases
(define pair (cons 3 4))
(car pair)  ;; 3
(cdr pair)  ;; 4


;; verify that (car (cons x y)) yields x for any objects x and y.
;; (car (cons x y)) -> (car (lambda (m) (m x y)))
;;                  -> ((lambda (m) (m x y)) (lambda (p q) p))
;;                  -> ((lambda (p q) p) x y)
;;                  -> x
;;
;; same way to verify (cdr (cons x y)) yields y for any objects x and y.
