#lang racket

(define (make-rand inter-seed)
  (define (rand-generator seed) 
    (let ((a 9)
          (b 7)
          (m 10240))
      (remainder (+ (* seed a) b) m)))
  (define (dispatch m)
    (cond ((eq? m 'generate) 
           (let ((next (rand-generator inter-seed)))
             (begin (set! inter-seed next) 
                    next)))
          ((eq? m 'reset) 
           (lambda (s) (set! inter-seed s)))
          (else (error "Invalid operaion"))))
  dispatch)

(define rand (make-rand 42))


;; test cases
(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)

((rand 'reset) 100)
(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)

((rand 'reset) 100)
(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
