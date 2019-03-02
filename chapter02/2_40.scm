#lang racket  ;; sicp package doesn't implement filter, accumulate.
(require math/number-theory)  ;; we need prime?


(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low
            (enumerate-interval (+ low 1) high))))

(define (accumulate op init seq)
  (foldr op init seq))

(define (flatmap op seq)
  (accumulate append '() (map op seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))  

(define (make-pair-sum pair)
  (list (car pair) 
        (cadr pair) 
        (+ (car pair) (cadr pair))))    

(define (unique-pairs n)
  (flatmap (lambda (i) 
             (map (lambda (j) (list i j)) 
                  (enumerate-interval 1 (- i 1)))) 
           (enumerate-interval 1 n)))


(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter 
        prime-sum?
        (unique-pairs n))))


;; test cases
(prime-sum-pairs 6)
