#lang sicp

;; Answer from: https://wizardbook.wordpress.com/2010/12/02/exercise-2-22/

(define (square x)
  (* x x))


(define (square-list-1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things)) answer))))
  (iter items nil))

;; The answer list in the reverse order of the one desired. Why?
;; In Louis’ first attempt, he has the arguments to the iterative call to iter the wrong way round. 
;; So his answer list is built up from an initial empty list by cons the current square to the current answer list. 
;; This is how the reverse procedure earlier was written.


(define (square-list-1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer (square (car things))))))
  (iter items nil))

;; This doesn’t work either. Explain.
;; His second attempt is using cons in reverse with a list value (not an atomic value) as the car 
;; and an atomic value (not a list) as the cdr and so creates a single, heavily nested cons cell.
