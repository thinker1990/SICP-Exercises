#lang racket

(define (multiple-dwelling)
  (let* ((baker (lambda (dwelling) (list-ref dwelling 0)))
         (cooper (lambda (dwelling) (list-ref dwelling 1)))
         (fletcher (lambda (dwelling) (list-ref dwelling 2)))
         (miller (lambda (dwelling) (list-ref dwelling 3)))
         (smith (lambda (dwelling) (list-ref dwelling 4)))
         (floors (list 1 2 3 4 5))
         (all-dwelling-arrangement (arrange floors)))
    (set! all-dwelling-arrangement
          (filter (lambda (dwelling)
                    (not (= (baker dwelling) 5)))
                  all-dwelling-arrangement))
    (set! all-dwelling-arrangement
          (filter (lambda (dwelling)
                    (not (= (cooper dwelling) 1)))
                  all-dwelling-arrangement))
    (set! all-dwelling-arrangement
          (filter (lambda (dwelling)
                    (not (= (fletcher dwelling) 5)))
                  all-dwelling-arrangement))
    (set! all-dwelling-arrangement
          (filter (lambda (dwelling)
                    (not (= (fletcher dwelling) 1)))
                  all-dwelling-arrangement))
    (set! all-dwelling-arrangement
          (filter (lambda (dwelling)
                    (> (miller dwelling) (cooper dwelling)))
                  all-dwelling-arrangement))
    (set! all-dwelling-arrangement
          (filter (lambda (dwelling)
                    (not (= (abs (- (smith dwelling) (fletcher dwelling))) 1)))
                  all-dwelling-arrangement))
    (set! all-dwelling-arrangement
          (filter (lambda (dwelling)
                    (not (= (abs (- (fletcher dwelling) (cooper dwelling))) 1)))
                  all-dwelling-arrangement))
    
    (map
     (lambda (dwelling)
       (list (list 'baker (baker dwelling))
             (list 'cooper (cooper dwelling))
             (list 'fletcher (fletcher dwelling))
             (list 'miller (miller dwelling))
             (list 'smith (smith dwelling))))
     all-dwelling-arrangement)))

(define (arrange floors)
  (cond [(null? floors) (list '())]
        [else
         (foldr append
                '()
                (map (lambda (floor)
                       (map (lambda (arrangement) (cons floor arrangement))
                            (arrange (items-except floor floors))))
                     floors))]))

(define (items-except e items)
  (cond [(null? items) '()]
        [(eq? (car items) e) (cdr items)]
        [else (cons (car items) (items-except e (cdr items)))]))


;; test cases
(multiple-dwelling)
;; '(((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1)))

;; A more elegant solution from: https://wizardbook.wordpress.com/2011/01/12/exercise-4-41/
