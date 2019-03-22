#lang sicp

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define (last-pair x) 
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))


(define z (make-cycle (list 'a 'b 'c)))

z  ;; #0=(mcons 'a (mcons 'b (mcons 'c #0#)))
;; z is x with last-pair set to x itself

(last-pair z)
;; will enter infinite loop, because the structure of z is circular, so (cdr x) will never be null.
