#lang sicp

;; An interesting solution from: https://sicp.readthedocs.io/en/latest/chp3/18.html

(define (circular? x) 
  (let ((traveled (list x)))
    (define (iter lst) 
      (if (null? lst)
        #f
        (let ((rest (cdr lst)))
          (if (memq rest traveled)
              #t
              (begin (append! traveled (list rest))
                     (iter rest))))))
    (iter x)))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x) 
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))


;; test cases
(define x1 (list 1 2 3))
(circular? x1)  ;; #f
(define x2 (list (list 1 2 3) (list 1 2 3)))
(circular? x2)  ;; #f
(define x3 (list x1 x1))
(circular? x3)  ;; #f

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define x4 (make-cycle (list 1 2 3)))
(circular? x4)  ;; #t
(define x5 (append x1 x4))
(circular? x5)  ;; #t
