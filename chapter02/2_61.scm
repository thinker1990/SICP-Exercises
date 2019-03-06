#lang racket

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? (car set) x) #t)
        ((> (car set) x) #f)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set) 
  (cond ((null? set) (list x))
        ((< x (car set)) (cons x set))
        ((equal? x (car set)) set)
        (else (cons (car set) (adjoin-set x (cdr set))))))

(define (intersection-set set1 set2) 
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
           (cond ((< x1 x2) (intersection-set (cdr set1) set2))
                 ((> x1 x2) (intersection-set set1 (cdr set2)))
                 (else (cons x1 (intersection-set (cdr set1) (cdr set2))))))))

(define (union-set set1 set2) 
  (if (or (null? set1) (null? set2))
      (append set1 set2)
      (let ((x1 (car set1))
            (x2 (car set2)))
           (cond ((< x1 x2) (cons x1 (union-set (cdr set1) set2)))
                 ((> x1 x2) (cons x2 (union-set set1 (cdr set2))))
                 (else (cons x1 (union-set (cdr set1) (cdr set2))))))))


;; test cases
(define set1 (list 1 2 3 4 5 6))
(define set2 (list 4 5 6 7 8 9))
(element-of-set? 4 set1)  ;; #t
(element-of-set? 1 set2)  ;; #f
(adjoin-set 5 set1)  ;; '(1 2 3 4 5 6)
(adjoin-set 1 set2)  ;; '(1 4 5 6 7 8 9)
(adjoin-set 10 set2)  ;; '(4 5 6 7 8 9 10)
(intersection-set set1 set2)  ;; '(4 5 6)
(union-set set1 set2)  ;; '(1 2 3 4 5 6 4 5 6 7 8 9)
