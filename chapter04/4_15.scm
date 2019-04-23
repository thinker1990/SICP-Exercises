#lang sicp

(define (run-forever)
  (run-forever))

(define (try p)
  (if (halt? p p)
      (run-forever)
      'halted))

(try try)
;; 1. if try can halt on itself, then (halt? try try) is true, and (try try) runs forever.
;;    but by definition (try try) should returns a value if try can halt.
;;    this violates the intended behavior of halts?
;; 2. if try can't halt on itself, then (halt? try try) is false, and a value 'halted returned.
;;    but by definition (try try) should run forever or raise an error if try can't halt.
;;    this violates the intended behavior of halts? too.
;; So, it is impossible to write a procedure halts? that correctly determines 
;; whether p halts on a for any procedure p and object a. 
