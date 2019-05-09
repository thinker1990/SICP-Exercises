
(define (analyze-amb exp)
  (let ((cprocs
         (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (let ((random-choice (random-choose choices)))
          (if (null? choices)
            (fail)
            (random-choices 
             env
             succeed
             (lambda ()
               (try-next (choices-except choices random-choice)))))))
      (try-next cprocs))))

(define (random-choose items) 
  (list-ref items 
            (random (length items))))

(define (choices-except items c)
  (cond ((null? items) null)
        ((equal? c (car items)) (cdr items))
        (else 
         (cons (car items) 
               (choices-except (cdr items) c)))))
