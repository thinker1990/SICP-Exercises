#lang sicp

;; Solution come from: http://community.schemewiki.org/?sicp-ex-4.36
(define (any-pythagorean-triple)
  (a-pythagorean-triple-greater-than 1))

(define (a-pythagorean-triple-greater-than low) 
  (let ((k (an-integer-starting-from low))) 
    (let ((i (an-integer-between low k))) 
      (let ((j (an-integer-between i k))) 
           (require (= (+ (* i i) (* j j)) (* k k)))
           (require (> (+ i j) k)) 
           (list i j k))))) 
