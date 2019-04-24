#lang sicp

;; Answer from: https://wizardbook.wordpress.com/2011/01/03/exercise-4-18/

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;; this will be transformed to:
(define (solve f y0 dt)
  (let ((y '*unassigned*)
        (dy '*unassigned*))
    (let ((a (integral (delay dy) y0 dt))
          (b (stream-map f y)))
      (set! u a)
      (set! v b))
    y))

;; let will be tranformed to lambda:
(define (solve f y0 dt)
  ((lambda (y dy)
    ((lambda (a b)
       (set! u a)
       (set! v b))
     (integral (delay dy) y0 dt)
     (stream-map f y))
    y)
   '*unassigned*
   '*unassigned*))

;; The arguments for the outer (lambda (y dy)..) are both '*unassigned.
;; The arguments for the inner (lambda (a b)..) are (integral (delay dy) yo dt) and (stream-map f y)
;; At this point in the evaluation both y and dy are still '*unassigned so this kind of transformation will not work.
