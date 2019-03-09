#lang racket

;; put and get implemetation from: https://stackoverflow.com/questions/5499005/how-do-i-get-the-functions-put-and-get-in-sicp-scheme-exercise-2-78-and-on
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) '()))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) 
               (operands exp) var))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? var val) 
  (and (number? var) (= var val)))


;; a. An elaborate answer from: https://wizardbook.wordpress.com/2010/12/07/exercise-2-73/

;; b. 
(define (install-deriv-sum-package)
  ;; internal procedures
  (define (addend args) (car args))
  (define (augend args) (cadr args))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (deriv-sum args var) 
    (make-sum (deriv (addend args) var) 
              (deriv (augend args) var)))
  ;; interface to the rest of the system
  (put 'deriv '+ deriv-sum)
  'done)

(define (install-deriv-product-package)
  ;; internal procedures
  (define (multiplier args) (car args))
  (define (multiplicand args) (cadr args))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          (else (list '* m1 m2))))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (deriv-product args var) 
    (make-sum (make-product (multiplier args) 
                            (deriv (multiplicand args) var)) 
              (make-product (multiplicand args) 
                            (deriv (multiplier args) var))))
  ;; interface to the rest of the system
  (put 'deriv '* deriv-product)
  'done)

;; test cases
(install-deriv-sum-package)
(install-deriv-product-package)
(define exp1 '(+ (* 2 x) (+ x y)))
(define exp2 '(* (* x y) (+ x 3)))

(deriv exp1 'x)  ;; 3
(deriv exp2 'x)  ;; (+ (* x y) (* (+ x 3) y))

;; c.
(define (install-deriv-exponentiation-package)
  ;; internal procedures
  (define (base args) (car args))
  (define (exponent args) (cadr args))
  (define (make-exponentiation base exp)
    (cond ((=number? exp 0) 1)
          ((=number? exp 1) base)
          (else (list '** base exp)))) 
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          (else (list '* m1 m2))))
  (define (deriv-exponentiation args var) 
    (make-product (make-product (make-exponentiation (base args) 
                                                     (- (exponent args) 1)) 
                                (exponent args)) 
                  (deriv (base args) var)))
  ;; interface to the rest of the system
  (put 'deriv '** deriv-exponentiation)
  'done)

;; test case
(install-deriv-exponentiation-package)
(deriv '(+ (** x 1) y) 'x)  ;; 1
(deriv '(+ (** x 2) y) 'x)  ;; (* x 2) 
(deriv '(+ (** x 5) y) 'x)  ;; (* (** x 4) 5) 

;; d. The only changes needed are to the installation of the procedures into the generic dispatch table.
