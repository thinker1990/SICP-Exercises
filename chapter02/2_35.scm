#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence) 
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))


(define (count-leaves tree)
  (accumulate 
    +
    0 
    (map (lambda (bran) 
           (if (pair? bran) (count-leaves bran) 1)) 
         tree)))


;; test cases
(count-leaves (list 1 2 3 4 5))  ;; 5
(count-leaves (list 1 2 3 (list 4 5 (list 6 (list 7)))))  ;; 7
