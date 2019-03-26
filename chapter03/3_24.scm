#lang sicp

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((sub-table 
             (assoc key-1 (cdr local-table) same-key?)))
        (if sub-table
            (let ((record 
                   (assoc key-2 (cdr sub-table) same-key?)))
              (if record (cdr record) #f))
            #f)))
    (define (insert! key-1 key-2 value)
      (let ((sub-table 
             (assoc key-1 (cdr local-table) same-key?)))
        (if sub-table 
            (let ((record 
                   (assoc key-2 (cdr sub-table) same-key?)))
              (if record 
                  (set-cdr! record value)
                  (set-cdr! sub-table (cons (cons key-2 value) 
                                            (cdr sub-table)))))
            (set-cdr! local-table 
                      (cons (list key-1 
                                  (cons key-2 value)) 
                            (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            (else (error "Unknown operation: TABLE" m))))  
    dispatch))

(define (assoc key records same-key?)
  (cond ((null? records) #f)
        ((same-key? key (caar records)) 
         (car records))
        (else (assoc key (cdr records) same-key?))))


;; test cases
(define table (make-table equal?))
(define get (table 'lookup))
(define put (table 'insert!))
(put 'number 'add 12)  ;; ok
(put 'complex 'add 13)  ;; ok
(get 'number 'add)  ;; 12
(get 'complex 'add)  ;; 13
(get 'complex 'sub)  ;; #f
(put 'complex 'add 15)  ;; ok
(get 'complex 'add)  ;; 15
