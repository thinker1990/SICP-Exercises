#lang racket

(define (attach-tag type-tag contents)
  (if (pair? contents)
      (cons type-tag contents)
      contents))

(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum) (car datum))
        (else "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (error "Bad tagged datum: CONTENTS" datum)))
