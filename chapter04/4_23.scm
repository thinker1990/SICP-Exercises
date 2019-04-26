#lang sicp

;; original version:
(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc 
                            (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence: ANALYZE"))
    (loop (car procs) (cdr procs))))

;; Alyssa's version:
(define (analyze-sequence exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs)) 
           ((car procs) env))
          (else ((car procs) env)
                (execute-sequence 
                 (cdr procs) env))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence: 
                ANALYZE"))
    (lambda (env) 
      (execute-sequence procs env))))


;; Answer from: https://wizardbook.wordpress.com/2011/01/04/exercise-4-23/
;; The book version generates the sequence of procedures calls once at analysis time 
;; and Alyssa’s version generates the sequence every time it is called at run-time.
;; Alyssa’s analyze-sequence returns a single lambda which calls execute-sequence at run-time 
;; and when that is called it builds another lambda which executes the analysed procedures in sequence. 
;; Since this is done at run-time, multiple calls to the lambda returned 
;; will once again compose another lambda to execute the sequence of analysed procedures.
;; Contrast this with the book version which generates the same lambda 
;; that Alyssa’s execute-sequence generates, but only once at analysis time.
