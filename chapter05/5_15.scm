(define (execute) 
  (let ((insts (get-contents pc)))
    (if (null? insts)
        'done
        (begin (set! execute-count (+ execute-count 1))
               ((instruction-execution-proc (car insts))) 
               (execute)))))
