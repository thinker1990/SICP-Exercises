#lang racket

(define (install-scheme-number-package) 
  (put 'negation '(scheme-number)
       (lambda (x) (tag (- x))))
  'done)

(define (install-rational-package)
  (put 'negation '(rational)
    (lambda (x) (tag (make-rat (negation (numer x)) 
                          (denom x)))))
  'done)

(define (install-complex-package)
  (define (negation-complex x)
    (make-from-real-imag (negation (real-part x)) 
                         (negation (imag-part x))))
  (put 'negation '(complex) 
    (lambda (x) (tag (negation-complex x))))
  'done)

(define (install-polynomial-package)
  (define (negation-terms terms)
    (if (null? terms)
        (the-empty-termlist)
        (cons (make-term (order (first-term terms)) 
                         (negation (coeff (first-term terms)))) 
              (negation-terms (rest-terms terms)))))
  (put 'negation '(polynomial) 
    (lambda (x) 
      (tag (make-polynomial (variable x) 
                            (negation-terms (term-list x))))))
  'done)

(define (negation x) (apply-generic 'negation x))


(define (sub-poly p1 p2)
  (add-poly p1 (negation p2)))
