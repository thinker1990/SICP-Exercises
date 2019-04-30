#lang sicp

;; I can't work out this exercise, answer from: http://community.schemewiki.org/?sicp-ex-4.34

(define (setup-environment) 
    (let ((initial-env 
           (extend-environment (primitive-procedure-names) 
                               (primitive-procedure-objects) 
                               the-empty-environment))) 
        (eval 
         '(begin 
              (define (cons cons-first cons-rest) 
                  (lambda (m) (m cons-first cons-rest))) 
              (define (car z) 
                  (z (lambda (p q) p))) 
              (define (cdr z) 
                  (z (lambda (p q) q))) 
              (define (null? c) 
                  (equal? c '()))) 
         initial-env) 
        initial-env)) 
 
(define (lazy-cons? procedure) 
    (let ((env (procedure-environment procedure))) 
        (and (not (null? (lookup-variable-value 'cons-first env))) 
             (not (null? (lookup-variable-value 'cons-rest env)))))) 
 
(define (lazy-cons-print object) 
    (define (lazy-cons-print-internal object n) 
        (if (not (null? object)) 
            (let* ((env (procedure-environment object)) 
                   (first (lookup-variable-value 'cons-first env)) 
                   (rest (lookup-variable-value 'cons-rest env))) 
                (if (> n 10) 
                    (display "...") 
                    (begin 
                        (let ((first-forced (force-it first))) 
                            (if (and (compound-procedure? first-forced) 
                                     (lazy-cons? first-forced)) 
                                (lazy-cons-print first-forced) 
                                (display first-forced))) 
                        (display " ") 
                        (lazy-cons-print-internal 
                         (force-it rest) 
                         (+ n 1))))))) 
    (display "(") 
    (lazy-cons-print-internal object 0) 
    (display ")")) 
 
(define (user-print object) 
    (if (compound-procedure? object) 
        (if (lazy-cons? object) 
            (lazy-cons-print object) 
            (display (list 'compound-procedure 
                           (procedure-parameters object) 
                           (procedure-body object) 
                           '<procedure-env>))) 
        (display object))) 
