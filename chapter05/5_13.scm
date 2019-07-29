;; Solution from: http://community.schemewiki.org/?sicp-ex-5.13

(define (lookup-register name)
  (let ((val (assoc name register-table)))
    (if val 
        (cadr val)
        (begin (allocate-register name)
               (lookup-register name)))))
