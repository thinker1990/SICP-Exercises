#lang sicp

(define (circular? x) 
  (let ((slower (forward 1 x))
        (faster (forward 2 x)))
    (define (chase)
      (cond ((null? slower) #f)
            ((null? faster) #f)
            ((eq? slower faster) #t)
            (else 
              (begin (set! slower (forward 1 slower))
                     (set! faster (forward 2 faster))
                     (chase)))))
    (chase)))

(define (forward step lst) 
  (cond ((null? lst) '())
        ((= step 0) lst)
        (else (forward (- step 1) (cdr lst)))))
  

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
(define (last-pair x) 
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define x4 (make-cycle (list 1 2 3)))
(circular? x4)  ;; #t
(define x5 (append x1 x4))
(circular? x5)  ;; #t
