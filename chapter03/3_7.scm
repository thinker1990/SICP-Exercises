#lang racket

;; A better solution from: https://wizardbook.wordpress.com/2010/12/14/exercise-3-7/

(define (make-account balance password)
  (let ((pass-list (list password)))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (joint new-password) 
      (set! pass-list (cons new-password pass-list)))
    (define (dispatch p m)
      (cond ((not (member p pass-list)) (lambda (x) "Incorrect password"))
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'joint) joint)
            (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch))


(define (make-joint account origin-password new-password)
  ((account origin-password 'joint) new-password)
  account)



;; test cases
(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
;; 60
(define another-acc (make-joint acc 'secret-password 'new-password))
((another-acc 'new-password 'withdraw) 20)
;; 40
