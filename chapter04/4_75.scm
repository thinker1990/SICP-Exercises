#lang sicp

(define (uniquely-asserted operand frame-stream)
  (stream-flatmap
    (lambda (frame)
      (let ((result (qeval operand (singleton-stream frame))))
        (cond [(stream-null? result) the-empty-stream]
              [(stream-null? (stream-cdr result)) result]
              [else the-empty-stream])))
  frame-stream))

(put 'unique 'qeval uniquely-asserted)
