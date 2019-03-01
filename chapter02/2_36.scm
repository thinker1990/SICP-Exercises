#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence) 
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))


(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map (lambda (seq) (car seq)) seqs)) 
            (accumulate-n op init (map (lambda (seq) (cdr seq)) seqs)))))


;; test cases
(define matrix (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(accumulate-n + 0 matrix)  ;; (22 26 30) 
