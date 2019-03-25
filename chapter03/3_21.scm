#lang sicp

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) 
  (set-car! queue item))
(define (set-rear-ptr! queue item) 
  (set-cdr! queue item))

(define (make-queue) (cons '() '()))
(define (empty-queue? queue) 
  (null? (front-ptr queue)))
(define (front-queue queue) 
  (if (empty-queue? queue)
      (error "FRONT called with an queue" queue)
      (car (front-ptr queue))))
(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue) 
           (begin (set-front-ptr! queue new-pair)
                  (set-rear-ptr! queue new-pair)
                  queue))
          (else 
           (begin (set-cdr! (rear-ptr queue) new-pair)
                  (set-rear-ptr! queue new-pair)
                  queue)))))
(define (delete-queue! queue) 
  (cond ((empty-queue? queue) 
         (error "DELETE! called with an empty queue" queue))
        (else 
         (begin (set-front-ptr! 
                 queue 
                 (cdr (front-ptr queue)))
                 queue))))

(define (print-queue queue) 
  (display (front-ptr queue))
  (newline))


;; test cases
(define q1 (make-queue))

(print-queue (insert-queue! q1 'a))
;; (a)

(print-queue (insert-queue! q1 'b))
;; (a b)

(print-queue (delete-queue! q1))
;; (b)

(print-queue (delete-queue! q1))
;; ()

;; the queue is a pair (cons front-ptr rear-ptr), 
;; which front-ptr point to a list with queue items 
;; and rear-ptr point to the last item of queue.
;; so, from the point of standard Lisp printer
;; queue is just a pair whose car is a list 
;; and cdr is the last item of the list.
