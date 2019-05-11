#lang racket

(define (if-fail? expr) 
  (tagged-list? expr 'if-fail)) 

(define (analyze-if-fail exp)
  (let ((first (analyze (cadr exp)))
        (second (analyze (caddr exp))))
    (lambda (env succeed fail)
      (first env
             (lambda (value fail2) 
               (succeed value fail2))
             (lambda () 
               (second env succeed fail))))))
