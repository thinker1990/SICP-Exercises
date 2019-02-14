#lang sicp

(define (cont-frac n d k)
    (define (cont-frac-helper count) 
        (if (= count k) 
            (/ (n count) (d count)) 
            (/ (n count) (+ (d count) (cont-frac-helper (inc count))))))
    (cont-frac-helper 1))

(define (inc x) (+ x 1))

(define (n i) 1)

(define (d i)
    (cond ((= i 1) 1)
          ((= i 2) 2)
          (else (let ((previous (d (- i 1)))
                      (pre-pre (d (- i 2)))) 
                     (cond ((even? previous) 1)
                           ((and (= previous 1) (even? pre-pre)) 1)
                           ((and (= previous 1) (= pre-pre 1)) (+ (d (- i 3)) 2))
                           (error "Impossible!"))))))


(define e-2 (cont-frac n d 20))
(display (+ e-2 2.0))
