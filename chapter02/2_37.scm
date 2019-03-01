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


(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))

(define (transpose mat)
  (accumulate-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))


;; test dot-product
(define v1 (list 1 2 3))
(define w1 (list 4 5 6))
(dot-product v1 w1)  ;; 1*4 + 2*5 + 3*6 = 32
;; test matrix-*-vector
(define m1 (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(matrix-*-vector m1 v1)  ;; (14 32 50)  
;; test transpose
(transpose m1)  ;; ((1 4 7) (2 5 8) (3 6 9))
;; test matrix-*-matrix
(define m2 (list (list 2 3) (list 4 5) (list 6 7))) 
(matrix-*-matrix m1 m2)  ;; ((28 34) (64 79) (100 124))
