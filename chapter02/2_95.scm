#lang racket
(require racket/trace)
(require "2_94.scm")

(define P1 (make-poly x '((2 1) (1 -2) (0 1))))
(define P2 (make-poly x '((2 11) (0 7))))
(define P3 (make-poly x '((1 13) (0 5))))

(define Q1 (mul P1 P2))
(define Q2 (mul P1 P3))


(trace gcd-terms)  ;; trace the execution of gcd-terms.

(define common-divisor (gcd-poly Q1 Q2)) 
;; >(gcd-terms
;;  '((4 11) (3 -22) (2 18) (1 -14) (0 7))
;;  '((3 13) (2 -21) (1 3) (0 5)))
;; >(gcd-terms
;;  '((3 13) (2 -21) (1 3) (0 5))
;;  '((2 1458/169) (1 -2916/169) (0 1458/169)))
;; >(gcd-terms '((2 1458/169) (1 -2916/169) (0 1458/169)) '())
;; <'((2 1458/169) (1 -2916/169) (0 1458/169))

(equ? common-divisor P1)  ;; #f
