#lang racket

(define (install-scheme-number-package) 
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  'done)

(define (install-rational-package)
  (define (rational-eq? x y)
    (= (* (numer x) (denom y)) (* (numer y) (denom x))))
  (put 'equ? '(rational rational) 
    (lambda (x y) (rational-eq? x y)))
  'done)

(define (install-complex-package)
  (define (complex-eq? x y)
    (and (= (real-part x) (real-part y)) 
         (= (imag-part x) (imag-part y))))
  (put 'equ? '(complex complex) 
    (lambda (x y) (complex-eq? x y)))
  'done)


(define (equ? x y)
  (apply-generic 'equ? x y))
