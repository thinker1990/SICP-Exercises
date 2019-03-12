#lang sicp

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (and (= (length args) 2) (not (same-type? type-tags)))  ;; compare type here
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((lower-type (lower type1 type2)))
                  (cond ((eq? lower-type type1) (apply-generic op (raise a1) a2))
                        ((eq? lower-type type2) (apply-generic op a1 (raise a2)))
                        (else (error "No method for these types"
                                     (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))


(define (same-type? type-tags)
  (if (or (null? type-tags) (null? (cdr type-tags)))
      #t
      (and (eq? (car type-tags) (cadr type-tags)) 
           (same-type? (cdr type-tags)))))                     

;; This is the only change point when adding new levels to the tower.
(define tower '(scheme-number rational real complex))

(define (lower x y) 
  (let ((x-level (member x tower))
        (y-level (member y tower)))
    (if (and x-level y-level) 
        (let ((x-len (length x-level))
              (y-len (length y-level)))
          (if (< x-len y-len)
              y
              x)) 
        (error "not compatible"))))
