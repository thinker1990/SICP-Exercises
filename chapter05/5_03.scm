(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))


;; assuming that good-enough? and improve operations are available as primitives.
(controller
 (assign guess (const 1.0))
 test-guess
   (test (op good-enough?) (reg guess))
   (branch done)
   (assign t (op improve) (reg guess))
   (assign guess (reg t))
   (goto (label test-guess))
 done)
