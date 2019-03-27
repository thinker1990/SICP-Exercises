#lang sicp

;; suppose (full-adder a b c-in sum c-out) is a primer function-box.
(define (ripple-carry-adder A B S C)
  (define (iter c-in a-in b-in sum)
    (let ((c-out (make-wire)))
      (if (null? a-in)
          'ok
          (begin 
            (full-adder 
              (car a-in)
              (car b-in)
              c-in
              (car sum)
              c-out)
            (iter 
              c-out 
              (cdr a-in)
              (cdr b-in)
              (cdr sum))))))
  (iter C A B S))


;; A more elaborate solution from: https://sicp.readthedocs.io/en/latest/chp3/30.html
