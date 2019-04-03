#lang sicp

;; a. in terms of mutexes
(define (make-semaphore n)
  (let ((mutex (make-mutex)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire) 
             (begin 
               (mutex 'acquire)
               (if (> n 0)
                   (begin 
                     (set! n (- n 1))
                     (mutex 'release))
                   (begin 
                     (mutex 'release)
                     (the-semaphore 'acquire)))))
            ((eq? m 'release) 
             (begin 
               (mutex 'acquire)
               (set! n (+ n 1))
               (mutex 'release)))))
    the-semaphore))

;; b. in terms of atomic test-and-set! operations
(define (make-semaphore n)
  (define (the-semaphore m)
    (cond ((eq? m 'acquire) 
           (if (test-and-dec! n)
               (the-semaphore 'acquire)))
          ((eq? m 'release) 
           (if (atomic-inc! n)
               (the-semaphore 'release)))))
  the-semaphore)

(define (test-and-dec! n)
  (let ((cell (list #f)))
    (if (= n 0) 
        #t
        (if (test-and-set! cell)
            #t
            (begin 
              (set! n (- n 1))
              (clear! cell))))))

(define (atomic-inc! n)
  (let ((cell (list #f)))
    (if (test-and-set! cell)
        #t
        (begin 
          (set! n (+ n 1)) 
          (clear! cell)))))
