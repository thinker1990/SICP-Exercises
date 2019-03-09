#lang racket

;; a. Each individual division should format its file as (cons division-type employee-records).
;;    Each division should define a procedure that take an employee name and employee-records and return the specified employee's record.
;;    Each division should put an item ('search-employee-by-name division-type custom-search-procedure) into table.
(define (get-record name file) 
  (let ((division (car file))
        (records (cdr file)))
    ((get 'search-employee-by-name division) name records)))

;; b. The record should be format as (cons division-type record-content)
;;    Each division should define a procedure that take an employee record and return the salary part.
;;    Each division should put an item ('get-salary division-type custom-procedure) into table.
(define (get-salary record)
  (let ((division (car record))
        (content (cdr record)))
    ((get 'get-salary division) content)))

;; c. 
(define (find-employee-record name files)
  (map get-record files))

;; d. Each new company must have its own unique division identifier 
;;    and use that to install their own specific versions of search-employee-by-name and get-salary.
(define (install-new-division)
  (put 'division-name 'search-employee-by-name custom-search-employee-by-name)
  (put 'division-name 'get-salary custom-get-salary))
