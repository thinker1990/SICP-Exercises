#lang sicp

(define (or-gate a b output)
  (define (nand-gate a b output) 
    (let ((inter-and 0))
      (begin 
        (and-gate a b inter-and)
        (inverter inter-and output))))
  (let ((not-a 0)
        (not-b 0))
    (begin 
      (inverter a not-a)
      (inverter b not-b)
      (nand-gate not-a not-b output))))


;; or-gate is composed of 2 NOT gate and 1 NAND gate, each NAND gate is composed of 1 AND gate and 1 NOT gate,
;; so the delay time of the or-gate is 3 * inverter-delay + and-gate-delay.
