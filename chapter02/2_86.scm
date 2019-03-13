#lang racket

;; I only show complex package presented by polar.
;; A more elaborate solution from: https://wizardbook.wordpress.com/2010/12/09/exercise-2-86/

(define (install-scheme-number-package)
  (put 'sin 'scheme-number sin)
  (put 'cos 'scheme-number cos)
  'done)

(define (install-rational-package)
  (put 'sin 'rational (lambda (x) (sin (raise x))))  ;; raise to real number
  (put 'cos 'rational (lambda (x) (cos (raise x))))  ;; raise to real number
  'done)

(define (install-real-package)
  (put 'sin 'real sin)
  (put 'cos 'real cos)
  'done)

(define (sin x) (apply-generic 'sin x))
(define (cos x) (apply-generic 'cos x))



;; in the polar package
(define (real-part z) 
  (mul (magnitude z) (cos (angle z))))

(define (imag-part z) 
  (mul (magnitude z) (sin (angle z))))
