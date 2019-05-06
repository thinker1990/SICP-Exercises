#lang racket

;; The order of the restrictions does NOT affect the answer. 
;; it DO affect the time to find an answer.
;; For more detailed answer, see: http://community.schemewiki.org/?sicp-ex-4.39
(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5))
        (cooper (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5))
        (miller (amb 1 2 3 4 5))
        (smith (amb 1 2 3 4 5)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (not (= cooper 1)))
    (require (not (= baker 5)))
    (require (> miller cooper))
    (require 
     (not (= (abs (- fletcher cooper)) 1)))
    (require
     (not (= (abs (- smith fletcher)) 1)))
    (require 
     (distinct? (list baker cooper fletcher miller smith)))
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher)
          (list 'miller miller)
          (list 'smith smith))))
