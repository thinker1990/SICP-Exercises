#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence) 
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))


(define (map p sequence)
  (accumulate 
    (lambda (x y) (cons (p x) y)) 
    nil 
    sequence))

;; test case
(map abs (list -1 2 -3 4 -5))  ;; (1 2 3 4 5)


(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

;; test cases
(append (list 1 2 3) (list 4 5 6))  ;; (1 2 3 4 5 6)


(define (length sequence)
  (accumulate 
    (lambda (x y) (inc y)) 
    0 
    sequence))

;; test cases
(length (list 1 2 3 4 5))  ;; 5
