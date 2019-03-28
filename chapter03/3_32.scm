#lang sicp

;; Answer from: http://community.schemewiki.org/?sicp-ex-3.32
;; 
;; For and-gate: both a1 a2 have and-action-procedure which contains after-delay
;; (define (and-action-procedure)
;;   (let ((new-value
;;       (logical-and (get-signal a1) (get-signal a2))))
;;       (after-delay
;;       and-gate-delay
;;       (lambda () (set-signal! output new-value)))))
;; 
;;  the point here is that new-value is calculated before delay
;;  if the segments list has LIFO, and the first wire a1 change first, then the result will be incorrect
;;  (a1, a2)
;;  (0, 1) initial
;;  (1, 1) a1 0 -> 1, then a1's and-action-procedure called -> new-value = 1, lambda procedure inserted into segment
;;  (1, 0) a2 1 -> 0, then a2's and-action-procedure called -> new-value = 0, lambda procedure inserted into segment
;;  then (propogate) called
;;  a2's (lambda() (set-signal! output new-value)) called, set output = 0 
;;  a1's (lambda() (set-signal! output new-value)) called, set output = 1
;; 
;;  so after this propogation we got output = 1, which is not correct.
