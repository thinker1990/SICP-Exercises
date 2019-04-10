#lang sicp

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define (stream-limit s tolerance)
  (let ((first (stream-car s))
        (second (stream-car (stream-cdr s))))
    (if (< (abs (- first second)) tolerance) 
        second 
        (stream-limit (stream-cdr s) tolerance))))
