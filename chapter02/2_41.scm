#lang racket  ;; sicp package doesn't implement filter, accumulate.


(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low
            (enumerate-interval (+ low 1) high))))

(define (accumulate op init seq)
  (foldr op init seq))

(define (flatmap op seq)
  (accumulate append '() (map op seq)))

(define (equal-sum? triple s)
  (equal? (+ (car triple) (cadr triple) (caddr triple)) s))     

(define (unique-triples n)
  (flatmap (lambda (i) 
             (flatmap (lambda (j) 
                        (map (lambda (k) (list i j k)) 
                             (enumerate-interval 1 (- j 1)))) 
                  (enumerate-interval 1 (- i 1)))) 
           (enumerate-interval 1 n)))


(define (equal-sum-triples n s)
  (filter (lambda (triple) (equal-sum? triple s))
          (unique-triples n)))


;; test cases
(equal-sum-triples 6 10)
;; ((5 3 2) (5 4 1) (6 3 1))
