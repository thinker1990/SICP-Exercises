(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))


;; data-path: https://www.processon.com/view/link/5cf66fe8e4b05d5b38c5a306
;; controller diagrams: https://www.processon.com/view/link/5cf67e8ae4b0123c616e6b37
