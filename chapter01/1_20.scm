#lang sicp

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))



;;  (gcd 206 40) = (gcd 40 (remainder 206 40)) = (gcd 40 6)
;;               = (gcd 6 (remainder 40 6)) = (gcd 6 4)
;;               = (gcd 4 (remainder 6 4)) = (gcd 4 2) 
;;               = (gcd 2 (remainder 4 2)) = (gcd 2 0)
;;               = 2
;;
;;  The remainder operations are performed 4 times in both
;;  normal-order evaluation and applicative-order evaluation.
;;  Because predict clause of if should be evaluated immediately.
;;  
;;  Other solution: https://github.com/qiao/sicp-solutions/blob/master/chapter1/1.20.scm
;;  Which I think is incorrect.
