(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (set! THE-ASSERTIONS
        (cons-stream assertion 
                     THE-ASSERTIONS))
  'ok)

;; Answer from: https://wizardbook.wordpress.com/2016/05/14/exercise-4-70/
;; THE-ASSERTIONS becomes an infinte, self-referential stream.
;; Using let in add-assertion! and add-rules! forces their delayed values 
;; and avoid the infinte stream.
