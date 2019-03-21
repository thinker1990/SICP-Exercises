#lang racket

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance 
                        amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                        MAKE-ACCOUNT" 
                       m))))
  dispatch)

;; global env:
;;   make-account -> parameters: balance
;;                   body: (define (withdraw amount)
;;                         ...
;;                         dispatch

(define acc (make-account 50))
;; global env:
;;   make-account -> parameters: balance
;;                   body: ...
;;    
;;   acc -> dispatch -> E1
;;
;; E1:
;;   balance = 50
;;   withdraw -> parameters: amount
;;               body: ...
;;   deposit  -> parameters: amount
;;               body: ...
;;   dispatch -> parameters: m
;;               body: ...

((acc 'deposit) 40)
;; global env:
;;   make-account -> parameters: balance
;;                   body: ...
;;    
;;   acc -> dispatch (pointing E1)
;;
;; E1: (pointing global env)
;;   balance = 50
;;   withdraw -> parameters: amount
;;               body: ...
;;   deposit  -> parameters: amount
;;               body: ...
;;   dispatch -> parameters: m
;;               body: ...
;; 
;; E2: (pointing E1)
;;   m = 'deposit
;;   evaluate body of dispatch:
;;   (cond ((eq? m 'withdraw) withdraw)
;;         ((eq? m 'deposit) deposit)
;;         (else (error "Unknown request: 
;;                       MAKE-ACCOUNT" 
;;                      m)))
;; 
;;   after evaluating body of dispatch:
;;   (deposit 40)
;; 
;; E3: (pointing E1)
;;   amount = 40
;;   evaluate body of deposit:
;;   (set! balance (+ balance amount))
;;   balance
;;   
;;   after evaluating body of deposit:
;; 
;; global env:
;;   make-account -> parameters: balance
;;                   body: ...
;;    
;;   acc -> dispatch -> E1
;;
;; E1:
;;   balance = 90
;;   withdraw -> parameters: amount
;;               body: ...
;;   deposit  -> parameters: amount
;;               body: ...
;;   dispatch -> parameters: m
;;               body: ...

((acc 'withdraw) 60)
;; global env:
;;   make-account -> parameters: balance
;;                   body: ...
;;    
;;   acc -> dispatch (pointing E1)
;;
;; E1: (pointing global env)
;;   balance = 90
;;   withdraw -> parameters: amount
;;               body: ...
;;   deposit  -> parameters: amount
;;               body: ...
;;   dispatch -> parameters: m
;;               body: ...
;; 
;; E2: (pointing E1)
;;   m = 'withdraw
;;   evaluate body of dispatch:
;;   (cond ((eq? m 'withdraw) withdraw)
;;         ((eq? m 'deposit) deposit)
;;         (else (error "Unknown request: 
;;                       MAKE-ACCOUNT" 
;;                      m)))
;; 
;;   after evaluating body of dispatch:
;;   (withdraw 60)
;; 
;; E3: (pointing E1)
;;   amount = 60
;;   evaluate body of withdraw:
;;   (if (>= balance amount)
;;       (begin (set! balance 
;;                    (- balance amount))
;;              balance)
;;       "Insufficient funds")
;;   
;;   after evaluating body of withdraw:
;; 
;; global env:
;;   make-account -> parameters: balance
;;                   body: ...
;;    
;;   acc -> dispatch -> E1
;;
;; E1:
;;   balance = 30
;;   withdraw -> parameters: amount
;;               body: ...
;;   deposit  -> parameters: amount
;;               body: ...
;;   dispatch -> parameters: m
;;               body: ...
;;
;; 1. The local state for acc is kept in E1 with a binding for local state balance.
;; 2. The local state for new account is kept by a distinct environment, so the change to balance
;;    is isolated. acc and acc2 does not share any environment structure but the definition of make-account.
