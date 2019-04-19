#lang sicp

(define (let*? exp) 
  (tagged-list? exp 'let*))
(define (let*-identifiers exp) 
  (cdr exp))
(define (let*-body exp) 
  (caddr exp))

(define (first-identifier identifiers)
  (car identifiers))
(define (rest-identifiers identifiers)
  (cdr identifiers))
(define (last-identifier? identifiers)
  (null? (rest-identifiers identifiers)))

(define (let*->nested-lets exp)
  (let ((identifiers (let*-identifiers exp))
        (body (let*-body exp)))
    (make-nested-lets identifiers body)))

(define (make-nested-lets identifiers body)
  (if (last-identifier? identifiers)
      (make-let (first identifiers) 
                body)
      (make-let (first identifiers) 
                (make-nested-lets (rest-identifiers identifiers) 
                                  body))))
(define (make-let identifiers body)
  (list 'let identifiers body))
