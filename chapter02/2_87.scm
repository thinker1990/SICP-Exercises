#lang racket

(define (install-polynomial-package) 
  (define (=zero-poly? poly) 
    (let ((terms (term-list poly)))
      (if (null? terms) 
          #t
          (and (=zero? (coeff (first-term terms))) 
               (=zero-poly? (rest-terms terms))))))
  (put '=zero? 'polynomial =zero-poly?)
  'done)
