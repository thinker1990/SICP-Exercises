#lang sicp

;; For more details, check: https://wizardbook.wordpress.com/2018/07/23/exercise-4-76/
(define (effective-conjoin conjuncts frame-stream)
  (let ((first-result (qeval (first-conjunct conjuncts) frame-stream))
        (rest-result (qeval (rest-conjuncts conjuncts) frame-stream)))
    (merge-stream first-result rest-result)))

(define (merge-streams left right)
  (stream-flatmap
   (lambda (left-frame)
     (stream-filter
      succeeded?
      (stream-map
       (lambda (right-frame)
         (merge-frames left-frame right-frame))
       right)))
   left))

(define (succeeded? frame)
  (not (failed? frame)))
 
(define (failed? frame)
  (eq? 'failed frame))

(define (merge-frames left right)
  (cond ((or (failed? left)
             (failed? right))  'failed)
        ((empty-frame? left) right)
        (else (let* ((binding (first-binding left))
                     (var (binding-variable binding))
                     (val (binding-value binding))
                     (extension (extend-if-possible var val right)))
                (if (failed? extension)
                    'failed
                    (merge-frames (rest-bindings left) extension))))))

(define empty-frame? null?)
(define first-binding car)
(define rest-bindings cdr)
