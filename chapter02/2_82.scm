#lang racket


(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (and (> (length args) 1) (not (same-type? type-tags)))  ;; compare type here
              (try-apply op 
                         (apply-coercion (get-valid-coercions type-tags) 
                                         args))
              (error 
               "No method for these types"
               (list op type-tags)))))))

(define (same-type? type-tags)
  (if (or (null? type-tags) (null? (cdr type-tags)))
      #t
      (and (eq? (car type-tags) (cadr type-tags)) 
           (same-type? (cdr type-tags)))))

(define (valid-coercion? coercion) 
  (not (member #f coercion)))           

(define (get-valid-coercions type-tags) 
  (filter valid-coercion? 
    (map (lambda (target-type) 
      (map (lambda (current-type) 
             (if (eq? current-type target-type) 
                 identity 
                 (get-coercion current-type target-type))) 
           type-tags)) 
         type-tags)))

(define (apply-coercion coercions args) 
  (if (null? args)
      '()
      (cons ((car coercions) (car args)) 
            (apply-coercion (cdr coercions) (cdr args)))))

(define (try-apply op arg-list) 
  (if (null? arg-list)  
      (error "Can't apply" op)
      (let ((args (car arg-list)))
        (let ((proc (get op (map type-tag args))))
          (if proc 
              (apply proc (map contents args))
              (try-apply op (cdr arg-list)))))))
