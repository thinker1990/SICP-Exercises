;; 1. The contents of register a be const 4 when control reaches there.

;; 2. 
(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels 
       (cdr text) 
       (lambda (insts labels)
         (let ((next-inst (car text)))
           (if (symbol? next-inst)
               (let ((val (assoc next-inst labels)))
                 (if val
                     (error "Same label is defined more than once: " next-inst)
                     (receive insts (cons (make-label-entry next-inst insts) labels))))
               (receive (cons (make-instruction next-inst) insts) labels)))))))
