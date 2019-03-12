#lang racket

(define (install-scheme-number-package) 
  (define (raise-to-rational x) 
    (make-rat x 1))
  (put 'raise 'scheme-number raise-to-rational)
  'done)

(define (install-rational-package)
  (define (raise-to-real x) 
    (make-real (/ (numer x) (denom x))))
  (put 'raise 'rational raise-to-real)
  'done)

(define (install-real-package)
  (define (raise-to-complex x)
    (make-complex-from-real-image x 0))
  (put 'raise 'real make-complex-from-real-image)
  'done)


(define (raise x)
  (apply-generic 'raise x))
