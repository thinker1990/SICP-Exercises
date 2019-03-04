#lang racket
(require sicp-pict)


;; a.  The painter that draws the outline of the designated frame.
(define (frame-outline frame) 
    (let ((origin (make-vect 0 0))
          (top-left (make-vect 0 1))
          (top-right (make-vect 1 1))
          (bottom-right (make-vect 1 0)))
        ((segments->painter 
            (list (make-segment origin top-left)
                  (make-segment origin bottom-right)
                  (make-segment top-left top-right)
                  (make-segment top-right bottom-right)))
            frame)))

;; b. The painter that draws an “X” by connecting opposite corners of the frame.
(define (frame-diagonals frame) 
    (let ((origin (make-vect 0 0))
          (top-left (make-vect 0 1))
          (top-right (make-vect 1 1))
          (bottom-right (make-vect 1 0)))
        ((segments->painter 
            (list (make-segment origin top-right)
                  (make-segment top-left bottom-right)))
            frame)))

;; c. The painter that draws a diamond shape by connect-ing the midpoints of the sides of the frame.
(define (frame-diamond frame) 
    (let ((top (make-vect 0.5 1))
          (left (make-vect 0 0.5))
          (right (make-vect 1 0.5))
          (bottom (make-vect 0.5 0)))
        ((segments->painter 
            (list (make-segment top left)
                  (make-segment top right)
                  (make-segment bottom left)
                  (make-segment bottom right)))
            frame)))

;; d. The wave painter.
;; No exactly right answer. An intersting solution from: https://sicp.readthedocs.io/en/latest/chp2/49.html
