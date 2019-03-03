#lang racket
(require sicp-pict)


(define (up-split painter n)
    (if (= n 0)
        painter
        (let ((smaller (up-split painter (- n 1))))
            (below painter (beside smaller smaller)))))


;; test cases
(paint (up-split einstein 3))
