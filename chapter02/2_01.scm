#lang sicp

(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (> (* n d) 0)
        (cons (abs (/ n g)) (abs (/ d g)))
        (cons (- (abs (/ n g))) (abs (/ d g))))))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x)))


;; test cases
(print-rat (make-rat 4 8))
(print-rat (make-rat -4 8))
(print-rat (make-rat 4 -8))
(print-rat (make-rat -4 -8))
