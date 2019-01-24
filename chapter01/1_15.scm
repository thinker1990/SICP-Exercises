#lang racket

(define (abs x)
    (if (< x 0)
        (- x)
        x))

(define (cube x)
    (* x x x))

(define (p x)
    (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
    (if (< (abs angle) 0.1)
        angle
        (p (sine (/ angle 3.0)))))


;; a. (sine 12.15) -> 
;;    (p (sine 4.05))
;;    (p (p (sine 1.35)))
;;    (p (p (p (sine 0.45))))
;;    (p (p (p (p (sine 0.15)))))
;;    (p (p (p (p (p (sine 0.05)))))
;;    (p (p (p (p (p 0.05)))))
;; The procedure p applied 5 times.
;;
;; b. time:   f(a) = (ceiling(/ (log (- a 0.1)) (log 3))) ~ O(log a)
;;    space:  f(a) = (ceiling(/ (log (- a 0.1)) (log 3))) ~ O(log a)
