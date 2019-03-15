#lang racket

;; Change the primitive operations to corresponding generic ones,
;; eg. + -> add
;;     * -> mul
(define (add-rat x y)
  (make-rat (add (mul (numer x) (denom y))
                 (mul (numer y) (denom x)))
            (mul (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (mul (numer x) (numer y))
            (mul (denom x) (denom y))))

(define (make-rat n d) (cons n d))

(define (numer x) (car x))

(define (denom x) (cdr x))
