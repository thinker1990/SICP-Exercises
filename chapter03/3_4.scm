#lang racket

(define (make-account balance password)
  (let ((max-try 7)
        (try 0))
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (call-the-cops) "Calling 911")
  (define (dispatch p m)
    (if (not (eq? p password)) 
        (lambda (x) 
          (if (= max-try try)
              (call-the-cops)
              (begin (set! try (+ try 1))
                     "Incorrect password")))
        (begin (set! try 0) 
               (cond ((eq? m 'withdraw) withdraw)
                     ((eq? m 'deposit) deposit)
                     (else (error "Unknown request: MAKE-ACCOUNT" m))))))
    dispatch))


;; test cases
(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
;; 60
((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
;; "Calling 911"
