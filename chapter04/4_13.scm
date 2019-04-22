#lang sicp

(define (make-unbound! var env)
  (let* ((frame (first-frame env))
         (binding (assoc var frame)))
    (if binding
        (set! frame (remove binding frame))
        'done)))

(define (remove target items)
  (define (iter left right)
    (if (eq? target (car right))
        (append left (cdr right))
        (iter (append left (list (car right))) 
              (cdr right))))
  (iter '() items))
