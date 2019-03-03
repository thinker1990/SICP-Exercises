#lang sicp

(define (make-vect x y) (cons x y))

(define (xcor-vect v) (car v))

(define (ycor-vect v) (cdr v))


(define (add-vect v1 v2)
    (make-vect (+ (xcor-vect v1) (xcor-vect v2)) 
               (+ (ycor-vect v1) (ycor-vect v2))))   
                
(define (sub-vect v1 v2)
    (make-vect (- (xcor-vect v1) (xcor-vect v2)) 
               (- (ycor-vect v1) (ycor-vect v2)))) 

(define (scale-vect factor v)
    (make-vect (* (xcor-vect v) factor)
               (* (ycor-vect v) factor)))


;; test case
(define v1 (make-vect 3 4))
(define v2 (make-vect 5 6))
(define v1-add-v2 (add-vect v1 v2))
(xcor-vect v1-add-v2)  ;; 8
(ycor-vect v1-add-v2)  ;; 10
(define v1-sub-v2 (sub-vect v1 v2))
(xcor-vect v1-sub-v2)  ;; -2
(ycor-vect v1-sub-v2)  ;; -2
(define v1-scale-2 (scale-vect 2 v1))
(xcor-vect v1-scale-2)  ;; 6
(ycor-vect v1-scale-2)  ;; 8
