#lang sicp

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (cc amount (except-first-denomination coin-values)) 
                 (cc (- amount (first-denomination coin-values)) coin-values)))))

  
;; Define the procedures first-denomination, except-first-denomination, 
;; and no-more? in terms of primitive operations on list structures.
(define (first-denomination coin-values)
  (car coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (no-more? coin-values)
  (null? coin-values))

;; test cases
(cc 100 us-coins)  ;; 292

;; Does the order of the list coin-values affect the answer producedby cc?
;; No
;; 
;; Why or whynot?
;; Because the procedure counts all possible combinations of coins.
(equal? (cc 100 us-coins) (cc 100 (reverse us-coins)))  ;; #t
