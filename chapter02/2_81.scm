#lang racket

;; 1. Q: What happens if apply-generic is called with two arguments of type scheme-number 
;;       or two arguments of type complex for an operation that is not found in the table for those types?
;;    A: The apply-generic will enter infinite recursion, each recursion try to coerce two argument to the same type,
;;       but they already are the same type.
;;    Q: What happens if we call exp with two complex numbers as arguments?
;;    A: Since we don't have coercion procedure complex->scheme-number install into coercion table, 
;;       and apply-generic keep trying to coerce to the same type (that is complex), so it will enter
;;       infinite recursion too.
;; 
;; 2. Q: Is Louis correct that something had to be done about coercion with arguments of the same type?
;;    A: No, it is unnecessary.
;;    Q: Does apply-generic work correctly as is?
;;    A: Absolutly.
;;
;; 3. Modify apply-generic so that it doesn’t try coercion if the two arguments have the same type.
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
                (let ((t1->t2 
                       (get-coercion type1
                                     type2))
                      (t2->t1 
                       (get-coercion type2 
                                     type1)))
                  (cond (t1->t2
                         (apply-generic 
                          op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic 
                          op a1 (t2->t1 a2)))
                        (else
                         (error 
                          "No method for 
                           these types"
                          (list 
                           op 
                           type-tags))))))
              (error 
               "No method for these types"
               (list op type-tags)))))))

(define (same-type? type-tags)
  (if (or (null? type-tags) (null? (cdr type-tags)))
      #t
      (and (eq? (car type-tags) (cadr type-tags)) 
           (same-type? (cdr type-tags)))))

  
;; test cases
(same-type? '(scheme-number scheme-number))  ;; #t
(same-type? '(scheme-number complex))  ;; #f
(same-type? '(complex complex))  ;; #t
(same-type? '(complex scheme-number))  ;; #f
