#lang sicp

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< (weight s1car) (weight s2car))
                  (cons-stream 
                   s1car 
                   (merge-weighted (stream-cdr s1) s2 weight)))
                 (else
                  (cons-stream 
                   s2car 
                   (merge-weighted s1 (stream-cdr s2) weight))))))))

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
    weight)))

;; a. 
(define pairs-orderby-sum 
  (weighted-pairs integers integers (lambda (pair) (+ (car pair) (cadr pair)))))

;; b.
(define (divisible-by n factors) 
  (cond [(null? factors) #f]
        [(= (remainder n (car factors)) 0) #t]
        [else (divisible-by n (cdr factors))]))

(define not-divisible-by-2-3-5 
  (stream-filter (lambda (n) (not (divisible-by n (list 2 3 5)))) 
                 integers))

(define ordered-pairs 
  (weighted-pairs not-divisible-by-2-3-5 
                  not-divisible-by-2-3-5 
                  (lambda (pair) (+ (* 2 (car pair)) 
                                    (* 3 (cadr pair)) 
                                    (* 5 (car pair) (cadr pair))))))
