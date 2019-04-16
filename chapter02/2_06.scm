#lang sicp

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n) 
  (lambda (f) (lambda (x) (f ((n f) x)))))


;; (define one (add-1 zero)) ->
;; (define one (lambda (f) (lambda (x) (f ((zero f) x))))) -> 
(define one (lambda (f) (lambda (x) (f x))))  

;; (define two (add-1 one)) -> 
;; (define two (lambda (f) (lambda (x) (f ((one f) x))))) -> 
(define two (lambda (f) (lambda (x) (f (f x))))) 

(define (add a b) 
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))


;; test cases
((one inc) 0)  ;; 1
((two inc) 0)  ;; 2
(((add-1 one) inc) 0)  ;; 2
(((add-1 two) inc) 0)  ;; 3
(((add one two) inc) 0)  ;; 3
