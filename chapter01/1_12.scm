#lang racket

(define (pascal-triangle row column)
    (cond ((= row 1) 1)
          ((= row 2) 1)
          ((= column 1) 1)
          ((= column row) 1)
          (else (+ (pascal-triangle (- row 1) (- column 1)) 
                   (pascal-triangle (- row 1) column)))))


;; test cases
(pascal-triangle 5 1)
(pascal-triangle 5 2)
(pascal-triangle 5 3)
(pascal-triangle 5 4)
(pascal-triangle 5 5)
