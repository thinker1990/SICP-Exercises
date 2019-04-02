#lang sicp

(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

;; Louis is wrong, there is no need to use a more sophisticated method, transfer here is not the same as exchange.
;; the amount of transfer is not compute in transfer, not like the difference of exchange. 
;; after difference computed, the actual difference may change, that is the problem of non-serialized exchange.
;; but transfer is different, it does not care about the difference of from-account and to-account,
;; as long as withdraw amount from from-account and deposit amount to to-account is serialized, the transferring is succeed.
;;
;; a more elaborate answer from: https://sicp.readthedocs.io/en/latest/chp3/44.html
