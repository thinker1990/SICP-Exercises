#lang sicp

(define (test-and-set! cell)
  (if (car cell) 
      true 
      (begin 
        (set-car! cell true) 
        false)))

;; initial cell: (list false)
;; two process p1, p2 try to acquire mutex at the same time.
;; p1 test (car cell) -> false
;; p2 test (car cell) -> false
;; p1 (set-car! cell true) then return false
;; p2 (set-car! cell true) then return false
;; so, p1 and p2 both acquire mutex successfuly. 
;; this violate the mutex's definition.
