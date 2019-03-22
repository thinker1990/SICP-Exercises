#lang sicp

(define (mystery x)
  (define (loop x y) 
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))


(define v (list 'a 'b 'c 'd))
(define w (mystery v))
v  ;; (a)
w  ;; (d c b a)
;; mystery x will build a new list with elements of x but reverse order.
;; (mystery v) evaluation:
;; loop 1:
;;   v : (a b c d)
;;   x : (a b c d)
;;   y : '()
;;   (null? x) : #f
;;   temp : (b c d)
;;   after (set-cdr! x y):
;;     v : (a)
;;     x : (a)
;;     y : '()
;;     temp : (b c d)
;; loop 2:
;;   v : (a)
;;   x : (b c d)
;;   y : (a)
;;   (null? x) : #f
;;   temp : (c d)
;;   after (set-cdr! x y):
;;     v : (a)
;;     x : (b a)
;;     y : (a)
;;     temp : (c d)
;; loop 3:
;;   v : (a)
;;   x : (c d)
;;   y : (b a)
;;   (null? x) : #f
;;   temp : (d)
;;   after (set-cdr! x y):
;;     v : (a)
;;     x : (c b a)
;;     y : (b a)
;;     temp : (d)
;; loop 4:
;;   v : (a)
;;   x : (d)
;;   y : (c b a)
;;   (null? x) : #f
;;   temp : '()
;;   after (set-cdr! x y):
;;     v : (a)
;;     x : (d c b a)
;;     y : (c b a)
;;     temp : '()
;; loop 5:
;;   v : (a)
;;   x : '()
;;   y : (d c b a)
;;   (null? x) : #t
;;   result y : (d c b a)
