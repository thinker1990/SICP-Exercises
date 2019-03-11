#lang racket

;; 1. By add the four put statements to the complex package,
;;    the four internal procedures are export from complex package to the outside world.
;;    So, the four selectors can be used on complex numbers.
;; 2. (magnitude z) -> (apply-generic 'magnitude '(complex (rectangular (3 4))))
;;                  -> (magnitude '(complex (rectangular (3 4))))
;;                  -> (apply-generic 'magnitude '(rectangular (3 4)))
;;                  -> (magnitude '(rectangular (3 4)))
;;                  -> (sqrt (+ (square 3) (square 4)))
;;                  -> 5
;;    apply-generic is invoked 2 times.
;;    first time the magnitude procedure in complex package is dispatched,
;;    second time the magnitude procedure in rectangular package is dispatched.
;;    
;; A more elaborate answer from: https://sicp.readthedocs.io/en/latest/chp2/77.html
