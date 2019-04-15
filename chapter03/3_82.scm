#lang sicp

(define (estimate-integral P x1 x2 y1 y2)
  (define experiment-stream 
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (cons-stream (P x y)
                   experiment-stream)))

  (let ((rect-area (* (abs (- x2 x1)) (abs (- y2 y1)))))
    (stream-scale
     (monte-carlo experiment-stream 0 0)
     rect-area)))
