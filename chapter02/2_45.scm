#lang racket
(require sicp-pict)


(define (split first-transform second-transform)
    (define (do-split painter n) 
        (if (= n 0)
            painter
            (let ((smaller (do-split painter (- n 1))))
                (first-transform painter (second-transform smaller smaller)))))
    do-split)

(define right-split (split beside below))
(define up-split (split below beside))


;; test cases
(paint (right-split einstein 3))
(paint (up-split einstein 3))
