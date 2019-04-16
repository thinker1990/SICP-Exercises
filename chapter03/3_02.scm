#lang racket

(define (make-monitored f)
  (let ((counter 0))
    (lambda (m) 
      (cond ((eq? m 'how-many-calls?) counter) 
            ((eq? m 'reset-count) (begin (set! counter 0) 'done)) 
            (else (begin (set! counter (+ counter 1)) (f m)))))))


;; test cases
(define s (make-monitored sqrt))
(s 100)
;; 10
(s 25)
;; 5
(s 'how-many-calls?)
;; 2
(s 'reset-count)
(s 'how-many-calls?)
;; 0
