#lang sicp

(define (count-pairs x)
  (let ((counted (list #f)))
    (define (count-helper lst)
      (if (null? lst)
          0
          (let ((first (car lst)))
            (if (and (pair? first) (not (memq first counted))) 
                (begin (append! counted (list first))
                       (display first)
                       (display counted)
                       (+ 1
                          (count-helper first)
                          (count-helper (cdr lst)))) 
                (count-helper (cdr lst))))))
    (if (null? x)
        0
        (+ 1 (count-helper x)))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x) 
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))


(define lst1 '(((a))))
(count-pairs lst1)  ;; 3

(define lst2 '((a) (b)))
(count-pairs lst2)  ;; 3

(define lst3 '((a b) (c d e)))
(count-pairs lst3)  ;; 3

(define lst4 (cons lst3 lst3))
(count-pairs lst4)  ;; 4
