#lang sicp

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup keys table)
      (cond ((null? keys) #f)
            ((null? table) #f)
            ((null? (cdr keys)) 
             (let ((record 
                    (assoc (car keys) (cdr table))))
               (if record 
                   (cdr record)
                   #f)))
            (else 
              (let ((sub-table 
                     (assoc (car keys) (cdr table))))
                (if sub-table 
                    (lookup (cdr keys) sub-table)
                    #f)))))

    (define (insert! keys value table)
      (if (null? (cdr keys))
          (let ((record 
                 (assoc (car keys) (cdr table))))
            (if record
                (set-cdr! record value)
                (set-cdr! table 
                          (cons (cons (car keys) value) 
                                (cdr table)))))
          (let ((sub-table 
                 (assoc (car keys) (cdr table))))
            (if sub-table
                (insert! (cdr keys) value sub-table)
                (let ((new-table (list (car keys))))
                  (begin (set-cdr! table 
                                   (cons new-table 
                                         (cdr table))) 
                         (insert! (cdr keys) value new-table))))))
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup) 
             (lambda (keys) (lookup keys local-table)))
            ((eq? m 'insert!)
             (lambda (keys value) (insert! keys value local-table)))
            (else (error "Unknown operation: TABLE" m))))  
    dispatch))


(define (assoc key records)
  (cond ((not (pair? records)) #f)
        ((null? records) #f)
        ((equal? key (caar records)) 
         (car records))
        (else (assoc key (cdr records)))))


;; test cases
(define table (make-table))
(define get (table 'lookup))
(define put (table 'insert!))
(put (list 'number 'add) 12)  ;; ok
(put (list 'complex 'add) 13)  ;; ok
(get (list 'number 'add))  ;; 12
(get (list 'complex 'add))  ;; 13
(get (list 'complex 'sub))  ;; #f
(put (list 'complex 'add) 15)  ;; ok
(get (list 'complex 'add))  ;; 15

(define multi-keys (list 'key-1 'key-2 'key-3 'key-4 'key-5 'key-6))
(put multi-keys 42)  ;; ok
(get multi-keys)  ;; 42
(put (list 'key-1 'key-2) 1024)
(get (list 'key-1 'key-2))  ;; 1024
(get multi-keys)  ;; #f
