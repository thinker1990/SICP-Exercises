#lang racket


;; a.
(define (reduce-terms n d) 
  (let ((GCD (real-gcd-terms n d)))
    (let ((O1 (max (order (first-term n)) (order (first-term d))))
          (O2 (order (first-term GCD)))
          (C (coeff (first-term GCD))))
      (let ((factor (expt C (+ (- O1 O2) 1))))
        (let ((n1 (mul-terms (list (make-term 0 factor)) n))
              (d1 (mul-terms (list (make-term 0 factor)) d)))
          (let ((n2 (car (div-terms n1 GCD)))
                (d2 (car (div-terms d1 GCD))))
            (let ((gcd-c (gcd-coeffs (append n2 d2))))
              (let ((nn (map (lambda (t) (make-term (order t) (/ (coeff t) gcd-c))) n2))
                    (dd (map (lambda (t) (make-term (order t) (/ (coeff t) gcd-c))) d2)))
                (list nn dd)))))))))


;; b.
(define (make-rat n d)
  (let ((reduced (reduce-terms n d)))
    (cons (car reduced) (cadr reduced))))


;; test cases
(define p1 '((1 1) (0 1)))
(define p2 '((3 1) (0 -1)))
(define p3 '((1 1)))
(define p4 '((2 1) (0 -1)))
(define rf1 (make-rat p1 p2))
(define rf2 (make-rat p3 p4))
(add-rat rf1 rf2)
;; '(((3 -1) (2 -2) (1 -3) (0 -1)) (4 -1) (3 -1) (1 1) (0 1))
