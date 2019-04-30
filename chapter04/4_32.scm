#lang sicp

(define (solve f y0 dt)
  (define y (integral dy y0 dt))
  (define dy (map f y))
  y)

;; the solve procedure in text book is a good example of full lazy lists described in this section.
;; both car and cdr of list is delayed, so we don't need to sprinkle our programs with explicit delay operations.
