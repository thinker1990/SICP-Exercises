#lang sicp

;; (remainder (* (expmod base (/ exp 2) m)
;;               (expmod base (/ exp 2) m))
;;            m))
;; 
;; This will double the call of function expmod.
;; See the difference between normal-order evaluation vs applicative-order evaluation.
