#lang racket


;; Here i only show sparse polynomial.
(define (install-sparse-package)
  ;; internal procedures
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))

  ;; representation of terms and term lists
  ⟨procedures adjoin-term … add-terms 
  from exercise 2.89⟩

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) 
                        (variable p2))
        (make-poly 
         (variable p1)
         (add-terms (term-list p1)
                    (term-list p2)))
        (error "Polys not in same var: ADD-POLY"
               (list p1 p2))))
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) 
                        (variable p2))
        (make-poly 
         (variable p1)
         (mul-terms (term-list p1)
                    (term-list p2)))
        (error "Polys not in same var: MUL-POLY"
               (list p1 p2))))

  ;; interface to rest of the system
  (define (tag p) (attach-tag 'sparse p))
  (put 'add '(sparse sparse)
       (lambda (p1 p2) 
         (tag (add-poly p1 p2))))
  (put 'mul '(sparse sparse)
       (lambda (p1 p2) 
         (tag (mul-poly p1 p2))))
  (put 'make 'sparse
       (lambda (var terms) 
         (tag (make-poly var terms))))
  'done)
