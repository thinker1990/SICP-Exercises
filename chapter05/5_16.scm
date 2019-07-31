(define (execute) 
  (let ((insts (get-contents pc)))
    (if (null? insts)
        'done
        (begin (if trace-on (display (caar insts)))
               ((instruction-execution-proc (car insts))) 
               (execute)))))
