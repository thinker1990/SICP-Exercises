#lang sicp

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x) 
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))


(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

z  ;; (a b c d)
(cdr x)  ;; (b)
;; (append x y) does not change list x and create a new list z:
;; x : (a b)
;; y : (c d)
;; z : (a b c d)

(define w (append! x y))
w  ;; (a b c d)
(cdr x)  ;; (b c d)
;; (append! x y) mutate list x by splicing y to x:
;; x : (a b c d)
;; y : (c d)
;; w : point to x
