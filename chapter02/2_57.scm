#lang racket

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp) 
           (if (same-variable? exp var) 1 0))
          ((sum? exp) 
           (make-sum (deriv (addend exp) var) 
                     (deriv (augend exp) var)))
          ((product? exp) 
           (make-sum (make-product (multiplier exp) 
                                   (deriv (multiplicand exp) var)) 
                     (make-product (multiplicand exp) 
                                   (deriv (multiplier exp) var))))
          ((exponentiation? exp) 
           (make-product (make-product (make-exponentiation (base exp) (- (exponent exp) 1)) 
                                       (exponent exp)) 
                         (deriv (base exp) var)))
          (else (error "unknow expression type: " exp))))


(define (variable? x)
    (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1)
         (variable? v2)
         (eq? v1 v2)))
         
(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))

(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          (else (list '* m1 m2))))

(define (make-exponentiation base exp)
    (cond ((=number? exp 0) 1)
          ((=number? exp 1) base)
          (else (list '** base exp))))          

(define (sum? exp)
    (and (pair? exp)
         (eq? (car exp) '+)))

(define (addend exp) 
    (cadr exp))

(define (augend exp) 
    (cond ((= (length exp) 2) 0) 
          ((= (length exp) 3) (caddr exp)) 
          (else (cons '+ (cddr exp)))))

(define (product? exp)
    (and (pair? exp) 
         (eq? (car exp) '*)))

(define (multiplier exp) 
    (cadr exp))

(define (multiplicand exp) 
    (cond ((= (length exp) 2) 1) 
          ((= (length exp) 3) (caddr exp)) 
          (else (cons '* (cddr exp)))))

(define (exponentiation? exp)
    (and (pair? exp) (eq? (car exp) '**)))

(define (base exp) (cadr exp))

(define (exponent exp) (caddr exp))

(define (=number? var val) 
    (and (number? var) (= var val)))


;; test case
(deriv '(* x y (+ x 3)) 'x)  
;; (+ (* x y) (* (+ x 3) y))
