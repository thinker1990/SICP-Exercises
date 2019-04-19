#lang sicp

;; (while test body) =>
;; (define while-iter 
;;   (if test
;;       (begin body while-iter)
;;       'done))

(define (while? exp)
  (tagged-list? exp 'while))
(define (while-test exp)
  (cadr exp))
(define (while-body exp)
  (caddr exp))
(define (while->if exp)
  (make-define 
   'while-iter 
   (make-if (while-test exp) 
            (sequence->exp
             (list (while-body exp) 
                   'while-iter))
            'done)))

(define (make-define var value)
  (list 'define var value))


;; (for init test update body) =>
;; (begin init (while test (begin body update)))

(define (for? exp)
  (tagged-list? exp 'for))
(define (for-init exp)
  (cadr exp))
(define (for-test exp)
  (caddr exp))
(define (for-update exp)
  (cadddr exp))
(define (for-body exp)
  (caddddr exp))
(define (for->while exp)
  (sequence->exp
   (list (for-init exp)
         (make-while (for-test exp)
                     (sequence->exp
                      (list (for-body exp)
                            (for-update exp)))))))

(define (make-while test body)
  (list 'while test body))
