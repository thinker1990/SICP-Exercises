#lang sicp

(define (make-duplex-pair item) 
  (list '() item '()))
(define (value-duplex duplex) 
  (cadr duplex))
(define (previous-ptr duplex) 
  (car duplex))
(define (next-ptr duplex) 
  (caddr duplex))
(define (set-previous! duplex ptr) 
  (if (null? duplex)
      '()
      (set-car! duplex ptr)))
(define (set-next! duplex ptr) 
  (if (null? duplex)
      '()
      (let ((last-pair (cddr duplex)))
        (set-car! last-pair ptr))))

(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) 
  (set-car! deque item))
(define (set-rear-ptr! deque item) 
  (set-cdr! deque item))

(define (make-deque) 
  (cons '() '()))

(define (empty-deque? deque) 
  (or (null? (front-ptr deque))
      (null? (rear-ptr deque))))

(define (front-deque deque) 
  (if (empty-deque? deque)
      (error "FRONT called with empty deque")
      (value-duplex (front-ptr deque))))

(define (rear-deque deque) 
  (if (empty-deque? deque)
      (error "REAR called with empty deque")
      (value-duplex (rear-ptr deque))))

(define (front-insert-deque! deque item)
  (let ((new-pair (make-duplex-pair item)))
    (if (empty-deque? deque) 
        (begin (set-front-ptr! deque new-pair)
               (set-rear-ptr! deque new-pair)
               deque) 
        (begin (set-previous! (front-ptr deque) new-pair)
               (set-next! new-pair (front-ptr deque))
               (set-front-ptr! deque new-pair)
               deque))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (make-duplex-pair item)))
    (if (empty-deque? deque) 
        (begin (set-front-ptr! deque new-pair)
               (set-rear-ptr! deque new-pair)
               deque) 
        (begin (set-previous! new-pair (rear-ptr deque))
               (set-next! (rear-ptr deque) new-pair)
               (set-rear-ptr! deque new-pair)
               deque))))

(define (front-delete-deque! deque) 
  (if (empty-deque? deque) 
      (error "DELETE! called with empty deque")
      (let ((head (front-ptr deque)))
        (begin (set-front-ptr! deque (next-ptr head))
               (set-previous! (front-ptr deque) '())
               (set-next! head '())
               deque))))

(define (rear-delete-deque! deque) 
  (if (empty-deque? deque) 
      (error "DELETE! called with empty deque")
      (let ((tail (rear-ptr deque)))
        (begin (set-rear-ptr! deque (previous-ptr tail))
               (set-next! (rear-ptr deque) '())
               (set-previous! tail '())
               deque))))

(define (print-deque deque) 
  (define (get-content items) 
    (if (null? items) 
        '() 
        (cons (value-duplex items) 
              (get-content (next-ptr items)))))
  (if (empty-deque? deque)
      (display '())
      (display (get-content (front-ptr deque))))
      (newline))


;; test cases
(define q1 (make-deque))

(print-deque (rear-insert-deque! q1 'a))
;; (a)
(print-deque (rear-insert-deque! q1 'b))
;; (a b)
(print-deque (front-delete-deque! q1))
;; (b)
(print-deque (front-delete-deque! q1))
;; ()

(print-deque (front-insert-deque! q1 'a))
;; (a)
(print-deque (front-insert-deque! q1 'b))
;; (b a)
(print-deque (rear-delete-deque! q1))
;; (b)
(print-deque (rear-delete-deque! q1))
;; ()

(print-deque (front-insert-deque! q1 'a))
;; (a)
(print-deque (front-insert-deque! q1 'b))
;; (b a)
(print-deque (front-delete-deque! q1))
;; (a)
(print-deque (front-delete-deque! q1))
;; ()

(print-deque (rear-insert-deque! q1 'a))
;; (a)
(print-deque (rear-insert-deque! q1 'b))
;; (a b)
(print-deque (rear-delete-deque! q1))
;; (a)
(print-deque (rear-delete-deque! q1))
;; ()