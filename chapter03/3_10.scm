#lang racket

;; A more elaborate solution from: https://sicp.readthedocs.io/en/latest/chp3/10.html

(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance 
                       (- balance amount))
                 balance)
          "Insufficient funds"))))


;; (let ((⟨var⟩ ⟨exp⟩)) ⟨body⟩) -> ((lambda (⟨var⟩) ⟨body⟩) ⟨exp⟩)
;; the above procedure make-withdraw is equal to:
(define (make-withdraw initial-amount)
  ((lambda (balance)
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance 
                       (- balance amount))
                 balance)
          "Insufficient funds"))) 
   initial-amount))

;; global env:
;;   make-withdraw -> parameters: initial-amount
;;                    body: ((lambda (balance)
;;                             (lambda (amount)
;;                               (if (>= balance amount)
;;                                   (begin (set! balance 
;;                                                (- balance amount))
;;                                          balance)
;;                                   "Insufficient funds"))) 
;;                           initial-amount)

(define W1 (make-withdraw 100))
;; global env: 
;;   make-withdraw -> parameters: initial-amount
;;                    body: ...
;;   W1 -> parameters: amount
;;         body: (lambda (amount)
;;                 (if (>= balance amount)
;;                     (begin (set! balance 
;;                                  (- balance amount))
;;                            balance)
;;                     "Insufficient funds")) -> E2
;;   
;; E1:
;;   initial-amount = 100 -> global env
;; 
;; E2:
;;   balance = initial-amount -> E1

(W1 50)
;; E3:
;;   amount = 50 -> E2
;;   evaluate body of W1: 
;;   (lambda (amount)
;;     (if (>= balance amount)
;;         (begin (set! balance 
;;                      (- balance amount))
;;                balance)
;;         "Insufficient funds"))
;;   
;;   after evaluating body of W1:  
;; global env: 
;;   make-withdraw -> parameters: initial-amount
;;                    body: ...
;;   W1 -> parameters: amount
;;         body: (lambda (amount)
;;                 (if (>= balance amount)
;;                     (begin (set! balance 
;;                                  (- balance amount))
;;                            balance)
;;                     "Insufficient funds")) -> E2
;;   
;; E1:
;;   initial-amount = 100 -> global env
;; 
;; E2:
;;   balance = initial-amount -50 = 100 - 50 = 50 -> E1
;; 
;; and there are no pointers to E3

(define W2 (make-withdraw 100))
;; global env: 
;;   make-withdraw -> parameters: initial-amount
;;                    body: ...
;;   W1 -> parameters: amount
;;         body: (lambda (amount)
;;                 (if (>= balance amount)
;;                     (begin (set! balance 
;;                                  (- balance amount))
;;                            balance)
;;                     "Insufficient funds")) -> E2
;;
;;   W2 -> parameters: amount
;;         body: (lambda (amount)
;;                 (if (>= balance amount)
;;                     (begin (set! balance 
;;                                  (- balance amount))
;;                            balance)
;;                     "Insufficient funds")) -> E4
;;   
;; E1:
;;   initial-amount = 100 -> global env
;; 
;; E2:
;;   balance = initial-amount -> E1
;;
;; E3:
;;   initial-amount = 100 -> global env
;; 
;; E4:
;;   balance = initial-amount -> E3