#lang racket

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? (car set) x) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set) 
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2) 
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2) 
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2) 
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (adjoin-set (car set1) (union-set (cdr set1) set2)))))


;; test cases
(define set1 (list 1 2 3 4 5 6))
(define set2 (list 4 5 6 7 8 9))
(element-of-set? 4 set1)  ;; #t
(element-of-set? 1 set2)  ;; #f
(adjoin-set 5 set1)  ;; '(1 2 3 4 5 6)
(adjoin-set 1 set2)  ;; '(1 4 5 6 7 8 9)
(intersection-set set1 set2)  ;; '(4 5 6)
(union-set set1 set2)  ;; '(1 2 3 4 5 6 7 8 9)
