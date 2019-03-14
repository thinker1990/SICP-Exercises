#lang racket


(define (adjoin-term term term-list)
  (cons term term-list))

(define (the-empty-termlist) '())

(define (first-term term-list) (car term-list))

(define (rest-terms term-list) (cdr term-list))

(define (empty-termlist? term-list) 
  (null? term-list))

;; The next three procedures are no need for dense polynomials.
;; (define (make-term order coeff) (list order coeff))
;; (define (order term) (car term))
;; (define (coeff term) (cadr term))

(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else 
          (let ((len1 (length L1))
                (len2 (length L2)))
            (cond ((= len1 len2) 
                   (adjoin-term (add (first-term L1) 
                                     (first-term L2))
                                (add-terms (rest-terms L1) 
                                           (rest-terms L2)))) 
                  ((> len1 len2) 
                   (adjoin-term (first-term L1) 
                                (add-terms (rest-terms L1) 
                                           L2)))
                  ((< len1 len2) 
                   (adjoin-term (first-term L2) 
                                (add-terms L1 
                                           (rest-terms L2)))))))))



(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms 
        (mul-term-by-all-terms (first-term L1) 
                               L2 
                               (- (+ (length L1) (length L2)) 1)) 
        (mul-terms (rest-terms L1) L2))))


(define (mul-term-by-all-terms term term-list count) 
  (define (mul-term-helper term L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (adjoin-term 
          (mul term (first-term L)) 
          (mul-term-helper term (rest-terms L)))))
  (define (padding-zero lst count) 
    (if (= count 0) 
        lst
        (padding-zero (append lst '(0)) (- count 1))))
  (let ((result (mul-term-helper term term-list)))
    (padding-zero result (- count (length result)))))


;; test cases
(define L1 '(1 2 5))
(define L2 '(1 0 1))
(add-terms L1 L2)  ;; (2 2 6)
(mul-terms L1 L2)  ;; (1 2 6 2 5)
