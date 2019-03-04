#lang racket
(require sicp-pict)

(define (below-v1 painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom 
            (transform-painter painter1
                               (make-vect 0.0 0.0)
                               split-point
                               (make-vect 1.0 0.0)))
          (paint-top 
            (transform-painter painter2
                               split-point
                               (make-vect 0.0 1.0)
                               (make-vect 1.0 0.5))))
      (lambda (frame) 
        (paint-bottom frame)
        (paint-top frame)))))

        
(define (below-v2 painter1 painter2)
  (rotate90 (beside (rotate270 painter1) 
                    (rotate270 painter2))))
