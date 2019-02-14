#lang sicp

(define (cont-frac n d k)
    (define (cont-frac-helper count) 
        (if (= count k) 
            (/ (n count) (d count)) 
            (/ (n count) (+ (d count) (cont-frac-helper (inc count))))))
    (cont-frac-helper 1))

(define (inc x) (+ x 1))

(define golden-ratio 1.618033988)
(define tolerance 0.00001)
(define (good-enough? ratio)
    (< (abs (- (/ 1 ratio) golden-ratio)) 
       tolerance))

(define (find-golden-ratio k) 
    (let ((ratio (cont-frac (lambda (i) 1.0)
                            (lambda (i) 1.0)
                            k))) 
         (if (good-enough? ratio)
             (display k)
             (find-golden-ratio (inc k)))))

(find-golden-ratio 1)

;; a. How large must you make k in order to get an approximation that is accurate to 4 decimal places?
;;    13
;;
;; b. Iterative version of cont-frac
(define (cont-frac n d k)
    (define (iter count result) 
        (if (= count k) 
            result 
            (iter (inc count) (/ (n count) (+ (d count) result)))))
    (iter 1 (/ (n 1) (d 1))))
