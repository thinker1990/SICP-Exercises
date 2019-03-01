#lang sicp

(define (reverse lst)
  (if (null? lst)
      lst
      (append (reverse (cdr lst)) (list (car lst)))))

(define (deep-reverse lst)
    (cond ((null? lst) lst) 
          ((not (pair? lst)) lst)
          (else (append (deep-reverse (cdr lst)) 
                        (list (deep-reverse (car lst)))))))


;; test cases
(define x (list (list 1 2) (list 3 4)))
x  ;; ((1 2) (3 4))
(reverse x)  ;; ((3 4) (1 2))
(deep-reverse x)  ;; ((4 3) (2 1))
(deep-reverse (list 1 2 3 4))  ;; (4 3 2 1)
