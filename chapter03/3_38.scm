#lang sicp

;; Peter: (set! balance (+ balance 10))
;; Paul: (set! balance (- balance 20))
;; Mary: (set! balance (- balance (/ balance 2)))

;; a. initial balance: 100
;;   1. balance: 100 + 10 = 110      (Peter)
;;      balance: 110 - 20 = 90       (Paul)
;;      balance: 90 - (90/2) = 45    (Mary)
;;   2. balance: 100 - 20 = 80       (Paul)
;;      balance: 80 + 10 = 90        (Peter)
;;      balance: 90 - (90/2) = 45    (Mary)
;;   3. balance: 100 - (100/2) = 50  (Mary)
;;      balance: 50 + 10 = 60        (Peter)
;;      balance: 60 - 20 = 40        (Paul)
;;   4. balance: 100 - (100/2) = 50  (Mary)
;;      balance: 50 - 20 = 30        (Peter)
;;      balance: 30 + 10 = 40        (Paul)   
;;   5. balance: 100 + 10 = 110      (Peter)
;;      balance: 110 - (110/2) = 55  (Mary)
;;      balance: 55 - 20 = 35        (Paul)
;;   6. balance: 100 - 20 = 80       (Paul)
;;      balance: 80 - (80/2) = 40    (Mary)
;;      balance: 40 + 10 = 55        (Peter)
;;
;; b. 110
;;    80
;;    50
;;    40
;;    60
;;    30
;;    90
