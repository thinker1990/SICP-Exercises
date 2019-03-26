#lang sicp

(define memo-fib
  (memoize 
    (lambda (n) 
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else 
              (+ (memo-fib (- n 1))
                 (memo-fib (- n 2))))))))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x) 
      (let ((computed-result (lookup x table)))
        (or computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

;; global env:
;;   memoize -> parameters: f
;;              body: ((lambda (table)
;;                       (lambda (x) 
;;                         (let ((computed-result (lookup x table)))
;;                           (or computed-result
;;                               (let ((result (f x)))
;;                                 (insert! x result table)
;;                                 result)))))
;;                     (make-table))
;; 
;;   memo-fib -> (lambda (x) ...)  (from E2)
;;   
;; E1: (point global env)
;;   f -> (lambda (n) ...)
;;   evaluate body of memoize generate E2
;;   result: (lambda (x) ...)
;;
;; E2: (point global env)
;;   table -> (make-table)
;;   result: (lambda (x) ...)

(memo-fib 3)
;; global env:
;;   memoize -> parameters: f
;;              body: ((lambda (table) ...)
;;                     (make-table))
;; 
;;   memo-fib -> (lambda (x) ...)  (from E2)
;;
;; E2: (point global env)
;;   table -> 1 : 1
;;            0 : 0
;;            2 : 1
;;            3 : 2
;;   result: (lambda (x) ...)
;; 
;; E3: (point E2)
;;   x -> 3
;;   evaluate body of memo-fib:
;;   (let ((computed-result (lookup x table)))
;;     (or computed-result
;;       (let ((result (f x)))
;;         (insert! x result table)
;;         result)))
;;   result: (f 3) -> (+ (mem-fib 2) (mem-fib 1))
;;   evaluate (mem-fib 2) generate E4
;;   evaluate (mem-fib 1) generate E5
;;   (+ (mem-fib 2) (mem-fib 1)) -> (+ 1 1) -> 2
;;   insert (3 2) to table from E2
;;   return 2
;;
;; E4: (point E2)
;;   x -> 2
;;   evaluate body of memo-fib result: 
;;   (f 2) -> (+ (mem-fib 1) (mem-fib 0))
;;   evaluate (mem-fib 1) generate E6
;;   evaluate (mem-fib 0) generate E7
;;   (+ (mem-fib 1) (mem-fib 0)) -> (+ 1 0) -> 1
;;   insert (2 1) to table from E2
;;   return 1
;; 
;; E6: (point E2)
;;   x -> 1
;;   evaluate body of memo-fib result: 
;;   (f 1) -> 1
;;   insert (1 1) to table from E2
;;   return 1
;;
;; E7: (point E2)
;;   x -> 0
;;   evaluate body of memo-fib result: 
;;   (f 0) -> 0
;;   insert (0 0) to table from E2
;;   return 0
;; 
;; E5: (point E2)
;;   x -> 1
;;   evaluate body of memo-fib result: 
;;   computed-result -> (lookup 1 table) -> 1
;;   return 1
;;
;; we can not (define memo-fib (memoize fib)) 
;; because memo-fib will recursively call fib but not mem-fib itself,
;; thus, it has no memoization effect at all.
