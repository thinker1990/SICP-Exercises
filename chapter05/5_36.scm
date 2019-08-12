;; Solution from: http://community.schemewiki.org/?sicp-ex-5.36

;; right to left, this is because in construct-arglist, compiler first reverse operand-code, then evaluate the parameters from left to right. 
;; To change the order, we can first evaluate the operands from left to right to get the arglist from right to left, then reverse the arglist. 
 
(define (construct-arglist operand-codes) 
  (let ((operand-codes operand-codes)) 
    (if (null? operand-codes) 
      (make-instruction-sequence '() '(argl) 
        `((assign argl (const ())))) 
      (let ((code-to-get-last-arg 
              (append-instruction-sequences 
                (car operand-codes) 
                (make-instruction-sequence '(val) '(argl) 
                  `((assign argl (op list) (reg val))))))) 
        (if (null? (cdr operand-codes)) 
          code-to-get-last-arg 
          (tack-on-instruction-sequence 
            (preserving '(env) 
              code-to-get-last-arg 
              (code-to-get-rest-args 
                (cdr operand-codes))) 
            (make-instruction-sequence '() '() 
              '((assign argl (op reverse) (reg argl)))))))))) 
