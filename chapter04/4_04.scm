#lang sicp

(define (eval exp env)
  (cond ((self-evaluating? exp) 
         exp)
        ...
        ((and? exp) 
         (eval-and (and-clauses exp) env))
        ((or? exp)
         (eval-or (or-clauses exp) env))
        ...
        (else
         (error "Unknown expression 
                 type: EVAL" exp))))

(define (and? exp)
  (tagged-list? exp 'and))
(define (and-clauses exp)
  (cdr exp))

(define (or? exp) 
  (tagged-list? exp 'or))
(define (or-clauses exp)
  (cdr exp))

(define (no-clauses? clauses)
  (null? clauses))
(define (first-clause clauses)
  (car clauses))
(define (rest-clauses clauses)
  (cdr clauses))

(define (eval-and clauses env)
  (if (no-clauses? clauses)
      'true
      (if (false? (eval (first-clause clause) env))
          'false
          (eval-and (rest-clauses clauses) env))))

(define (eval-or clauses env)
  (if (no-clauses? clauses)
      'false
      (if (true? (eval (first-clause clause) env))
          'true
          (eval-or (rest-clauses clauses) env))))


;; implement and and or as derived expressions
(define (and->if exp)
  (expand-and-clauses (and-clauses exp)))
(define (expand-and-clauses clauses)
  (if (no-clauses? clauses)
      'true
      (make-if (first-clause clauses)
               (expand-and-clauses (rest-clauses clauses))
               'false)))

(define (or->if exp)
  (expand-or-clauses (and-clauses exp)))
(define (expand-or-clauses clauses)
  (if (no-clauses? clauses)
      'false
      (make-if (first-clause clauses)
               'true
               (expand-or-clauses (rest-clauses clauses)))))
