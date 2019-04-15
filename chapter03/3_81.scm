#lang sicp

(define (make-rand request-stream random-seed)
  (let ((current-request (stream-car request-stream)))
    (cond [(eq? current-request 'generate) 
           (cons-stream 
            (rand-update random-seed) 
            (make-rand (stream-cdr request-stream) (rand-update random-seed)))]
          [(pair? current-request) 
           (cons-stream 
            (cdr current-request)
            (make-rand (stream-cdr request-stream) (cdr current-request)))]
          [else (error "Invalid request:" current-request)])))

(define (rand request-stream)
  (make-rand request-stream 42))
