#lang racket

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? (car set) x) #t)
        (else (element-of-set? x (cdr set)))))

;; no need to first check if x in set.
;; time: O(1)
(define (adjoin-set x set) 
  (cons x set))

(define (intersection-set set1 set2) 
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2) 
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;; append two set directly.
;; time: O(n)
(define (union-set set1 set2) 
  (append set1 set2))


;; test cases
(define set1 (list 1 2 3 4 5 6))
(define set2 (list 4 5 6 7 8 9))
(element-of-set? 4 set1)  ;; #t
(element-of-set? 1 set2)  ;; #f
(adjoin-set 5 set1)  ;; '(5 1 2 3 4 5 6)
(adjoin-set 1 set2)  ;; '(1 4 5 6 7 8 9)
(intersection-set set1 set2)  ;; '(4 5 6)
(union-set set1 set2)  ;; '(1 2 3 4 5 6 4 5 6 7 8 9)

;; A more elaborate solution from: https://wizardbook.wordpress.com/2010/12/07/exercise-2-60/
