(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

(controller
 (assign product (const 1))
 (assign counter (const 1))
 test-counter
   (test (op >) (reg counter) (reg n))
   (branch (label done))
   (assign t1 (op *) (reg product) (reg counter))
   (assign t2 (op +) (reg counter) (const 1))
   (assign product (reg t1))
   (assign counter (reg t2))
   (goto (label test-counter))
 done)
