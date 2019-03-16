#lang racket
(require racket/trace)


;; a.
(define (pseudoremainder-terms dividend divisor) 
    (let ((O1 (order (first-term dividend)))
          (O2 (order (first-term divisor)))
          (c (coeff (first-term divisor))))
        (let ((factor (expt c (+ (- O1 O2) 1))))
            (remainder-terms 
              (mul-terms (list (make-term 0 factor)) dividend) 
              divisor))))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (pseudoremainder-terms a b))))


(define P1 (make-poly x '((2 1) (1 -2) (0 1))))
(define P2 (make-poly x '((2 11) (0 7))))
(define P3 (make-poly x '((1 13) (0 5))))

(define Q1 (mul P1 P2))
(define Q2 (mul P1 P3))

;; test cases
(trace gcd-terms)  ;; trace the execution of gcd-terms.
(gcd-terms Q1 Q2)  ;; ((2 1458) (1 -2916) (0 1458))
;; >(gcd-terms
;;   '((4 11) (3 -22) (2 18) (1 -14) (0 7))
;;   '((3 13) (2 -21) (1 3) (0 5)))
;; >(gcd-terms '((3 13) (2 -21) (1 3) (0 5)) '((2 1458) (1 -2916) (0 1458)))
;; >(gcd-terms '((2 1458) (1 -2916) (0 1458)) '())
;; <'((2 1458) (1 -2916) (0 1458))


;; b.
(define (real-gcd-terms a b)
  (if (empty-termlist? b)
      (simply-coeff a)
      (real-gcd-terms b (pseudoremainder-terms a b))))

(define (simply-coeff term-list) 
  (let ((gcd-c (gcd-coeffs term-list)))
    (map 
      (lambda (term) 
        (make-term (order term) 
                   (/ (coeff term) gcd-c))) 
      term-list)))

(define (gcd-coeffs term-list) 
  (if (empty-termlist? term-list)
      (the-empty-term-list)
      (let ((coeff-list (map coeff term-list)))
        (accumulate gcd (car coeff-list) coeff-list))))

(define accumulate foldr)  ;; foldr is from racket package.


;; test cases
(trace real-gcd-terms)  ;; trace the execution of gcd-terms.
(real-gcd-terms Q1 Q2)  ;; ((2 1) (1 -2) (0 1))
;; >(real-gcd-terms
;;   '((4 11) (3 -22) (2 18) (1 -14) (0 7))
;;   '((3 13) (2 -21) (1 3) (0 5)))
;; >(real-gcd-terms '((3 13) (2 -21) (1 3) (0 5)) '((2 1458) (1 -2916) (0 1458)))
;; >(real-gcd-terms '((2 1458) (1 -2916) (0 1458)) '())
;; <'((2 1) (1 -2) (0 1))
