#lang racket

;; Solution from: http://community.schemewiki.org/?sicp-ex-2.58
;; We’re only going to bother with part2 here, 
;; because the solution for that is also a solution for part1.

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
          (else (list a1 '+ a2))))

(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          (else (list m1 '* m2))))        

(define (operation exp)
    (if (memq '+ exp) '+ '*)) 

(define (sum? exp)
    (and (pair? exp)
         (eq? (operation exp) '+)))

(define (addend exp) 
    (define (iter exp result)
        (if (eq? (car exp) '+)
            result
            (iter (cdr exp) (append result (list (car exp))))))
    (let ((result (iter exp '())))
        (if (= (length result) 1)
            (car result)
            result)))

(define (augend exp) 
    (let ((result (cdr (memq '+ exp))))
        (if (= (length result) 1)
            (car result)
            result)))

(define (product? exp)
    (and (pair? exp) 
         (eq? (operation exp) '*)))

(define (multiplier exp) 
    (define (iter exp result)
        (if (eq? (car exp) '*)
            result
            (iter (cdr exp) (append result (list (car exp))))))
    (let ((result (iter exp '())))
        (if (= (length result) 1) 
            (car result) 
            result)))

(define (multiplicand exp) 
    (let ((result (cdr (memq '* exp))))
        (if (= (length result) 1) 
            (car result) 
            result)))

(define (=number? var val) 
    (and (number? var) (= var val)))


;; test case
(deriv '(x + 3 * (x + y + 2)) 'x)  ;; 4
