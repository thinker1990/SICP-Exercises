#lang sicp

;; (define (expmod base exp m)
;;     (remainder (fast-expt base exp) m))
;; 
;; This will not serve as well for our fast prime tester.
;; When exp is large, fast-expt will be slow and likely cause overflow.
;; 
;; Better solution: https://sicp.readthedocs.io/en/latest/chp1/25.html
