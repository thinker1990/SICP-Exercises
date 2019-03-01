#lang sicp

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequence)
  (if (null? sequence) 
      initial
      (op (car sequence)
          (fold-right op
                      initial
                      (cdr sequence)))))


(define (reverse-1 sequence)
    (fold-right 
        (lambda (item reversed) (append reversed (list item)))
        nil 
        sequence))    
        
(define (reverse-2 sequence)
    (fold-left 
        (lambda (reversed item) (cons item reversed))
        nil
        sequence))        


;; test cases
(define lst (list 1 2 3 4 5))
(reverse-1 lst)  ;; (5 4 3 2 1)
(reverse-2 lst)  ;; (5 4 3 2 1)
