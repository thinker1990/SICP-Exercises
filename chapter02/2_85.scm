#lang racket

(require "2_79.scm")
(require "2_84.scm")


(define (install-complex-package) 
  (define (project-to-real x) 
    (let ((real (real-part x)))
      (if (equ? (raise real) x) 
          real 
          #f)))
  (put 'project 'complex project-to-real)
  'done)

(define (install-real-package)
  (define (project-to-scheme-number x)
    (let ((rounded (round (value x)))) 
      (if (= (make-real rounded) x)
          rounded
          #f)))
  (put 'project 'real project-to-scheme-number)
  'done)

(define (install-rational-package)
  (define (project-to-scheme-number x) 
    (let ((numer (numer x)))
      (if (equ? (raise numer) x)
          numer
          #f)))
  (put 'project 'rational project-to-scheme-number)
  'done)

(define (install-scheme-number-package)
  (define (can-not-project x) 
    #f)
  (put 'project 'scheme-number can-not-project)
  'done)

(define (project x) (apply-generic 'project x))

(define (drop x) 
  (let ((projected (project x)))
    (if (projected) 
        (drop projected)
        x)))


(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (reduce-type (apply proc (map contents args)))
          (if (and (= (length args) 2) (not (same-type? type-tags)))  ;; compare type here
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((lower-type (lower type1 type2)))
                  (cond ((eq? lower-type type1) (apply-generic op (raise a1) a2))
                        ((eq? lower-type type2) (apply-generic op a1 (raise a2)))
                        (else (error "No method for these types"
                                     (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))

;; From: https://wizardbook.wordpress.com/2010/12/08/exercise-2-85/
;; only certain operations will result in an answer that can be
;; projected e.g. it makes no sense to project the answer to zero?
(define (reduce-type x)
  (cond ((eq? op 'add) (drop x))
        ((eq? op 'sub) (drop x))
        ((eq? op 'mul) (drop x))
        ((eq? op 'div) (drop x))
        (else x)))
