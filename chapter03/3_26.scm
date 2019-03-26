#lang sicp

(define (entry tree)
  (car tree))
(define (left-branch tree)
  (cadr tree))
(define (right-branch tree)
  (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))

(define (assoc key records)
  (if (null? records)
      #f
      (let ((root (car (entry records))))
        (cond ((= key root) (entry records)) 
              ((< key root) 
               (assoc key (left-branch records)))
              ((> key root) 
               (assoc key (right-branch records)))))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table (adjoin key value (cdr table)))))
  'ok)

(define (adjoin key value tree)
  (if (null? tree) 
      (make-tree (cons key value) '() '())
      (let ((root (car (entry tree))))
        (if (< key root)
            (make-tree 
              (entry tree)
              (adjoin key value (left-branch tree))
              (right-branch tree))
            (make-tree 
              (entry tree)
              (left-branch tree)
              (adjoin key value (right-branch tree)))))))

(define (make-table)
  (list '*table*))


;; test cases
(define table (make-table))
(insert! 3 'hello table)  ;; ok
(insert! 2 'scheme table)  ;; ok
(insert! 1 'C# table)  ;; ok
(insert! 4 'python table)  ;; ok
(insert! 5 'go table)  ;; ok

(lookup 1 table)  ;; C#
(lookup 2 table)  ;; scheme
(lookup 3 table)  ;; hello
(lookup 4 table)  ;; python
(lookup 5 table)  ;; go
(lookup 0 table)  ;; #f
(insert! 5 'golang table)  ;; ok
(lookup 5 table)  ;; golang
