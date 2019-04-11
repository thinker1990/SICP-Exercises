#lang sicp

(define (triples s t u)
  (cons-stream 
    (list (stream-car s) (stream-car t) (stream-car u)) 
    (interleave 
      (stream-map (lambda (x) (append (list (stream-car s)) x)) 
                  (stream-cdr (paris t u))) 
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(stream-filter (lambda (triple) (Pythagorean? triple)) 
  (triples integers integers integers))

(define (Pythagorean? triple)
  (= (square (caddr triple)) 
     (+ (square (car triple)) 
        (square (cadr triple)))))
