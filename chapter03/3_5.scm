#lang sicp

(define (monte-carlo trails experiment)
  (define (iter trails-remaining trails-passed)
    (cond ((= trails-remaining 0) 
           (/ trails-passed trails))
          ((experiment) 
           (iter (- trails-remaining 1) 
                 (+ trails-passed 1)))
          (else 
           (iter (- trails-remaining 1) 
                 trails-passed))))
  (iter trails 0))

(define (estimate-integral P x1 x2 y1 y2 trails)
  (define (experiment) 
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (P x y)))
  (let ((rect-area (* (abs (- x2 x1)) (abs (- y2 y1))))
        (fraction (monte-carlo trails experiment)))
    (* rect-area fraction)))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (square x) (* x x))


;; test cases
(define (in-unit-circle x y)
  (<= (+ (square (- x 1)) 
        (square (- y 1))) 
      1))

(define pi-1 (estimate-integral in-unit-circle 0.0 2.0 0.0 2.0 1000))
pi-1  ;; 3.18
(define pi-2 (estimate-integral in-unit-circle 0.0 2.0 0.0 2.0 10000))
pi-2  ;; 3.1352
