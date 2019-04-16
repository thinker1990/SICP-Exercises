#lang racket

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))


(factorial 6)
;; for recursive version:
;; global env : factorial binding
;; E1: factorial with n = 6   ->  global env
;; E2: factorial with n = 5   ->  global env
;; E3: factorial with n = 4   ->  global env
;; E4: factorial with n = 3   ->  global env
;; E5: factorial with n = 2   ->  global env
;; E6: factorial with n = 1   ->  global env
;; 
;; for iterative version:
;; global env : factorial binding
;;              fact-iter binding
;; E1: factorial with n = 6   ->  global env
;; E2: fact-iter with product = 1, counter = 1, max-count = 6   ->  global env
;; E3: fact-iter with product = 2, counter = 2, max-count = 6   ->  global env
;; E2: fact-iter with product = 6, counter = 3, max-count = 6   ->  global env
;; E2: fact-iter with product = 24, counter = 4, max-count = 6   ->  global env
;; E2: fact-iter with product = 120, counter = 5, max-count = 6   ->  global env
;; E2: fact-iter with product = 720, counter = 6, max-count = 6   ->  global env
;; E2: fact-iter with product = 720, counter = 7, max-count = 6   ->  global env
