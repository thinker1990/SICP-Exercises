#lang racket

(define (install-scheme-number-package) 
  (put '=zero? 'scheme-number
       (lambda (x) (= x 0)))
  'done)

(define (install-rational-package)
  (put '=zero? 'rational
    (lambda (x) (= (numer x) 0)))
  'done)

(define (install-complex-package)
  (define (=zero? x)
    (and (= (real-part x) 0) 
         (= (imag-part x) 0)))
  (put '=zero? 'complex
    (lambda (x) (=zero? x)))
  'done)


(define (=zero? x)
  (apply-generic '=zero? x))
