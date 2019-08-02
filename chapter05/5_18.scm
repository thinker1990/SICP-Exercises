(define (make-register name)
  (let ((contents '*unassigned*))
    (define (dispatch message)
      (cond ((eq? message 'get) contents)
            ((eq? message 'set) 
             (lambda (value) 
               (display (list 'register-name name
                              'old-value contents
                              'new-value value))
               (set! contents value)))
            (else (error "Unknown request: REGISTER" message))))
    dispatch))
(define (get-contents register) (register 'get))
(define (set-contents! register value) 
  ((register 'set) value))