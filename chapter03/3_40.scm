#lang sicp

(define x 10)
(parallel-execute 
  (lambda () (set! x (* x x)))
  (lambda () (set! x (* x x x))))

;; 1000000: P1 sets x to 100 and then P2 set x to 1000000.
;; 1000000: P2 set x to 1000 and then P1 sets x to 1000000.
;; 100: P1 accesses x (10:twice), then P2 sets x to 1000, then P1 sets x to 100.
;; 1000: P2 accesses x (10:triple), then P1 sets x to 100, then P2 sets x to 1000.
;; 10000: P1 accesses x(10), then P2 sets x to 1000, P1 accesses x(1000) again, then P1 sets x to 10000.
;; 10000: P1 accesses x(10), then P2 accesses x(10), then P1 accesses x(10), then P2 accesses x(10), then P1 sets x to 100, then P2 accesses x(100), then P2 sets x to 10*10*100.
;; 100000: P1 accesses x(10), then P2 accesses x(10), then P1 accesses x(10), then P1 sets x to 100, then P2 accesses x(100), then P2 accesses x(100), then P2 sets x to 10*100*100.
;; 10000: P2 accesses x(10), then P1 accesses x(10), then P2 accesses x(10), then P2 accesses x(10), then P2 sets x to 1000, then P1 accesses x(1000), then P1 sets x to 10*1000.

(define x 10)
(define s (make-serializer))
(parallel-execute 
  (s (lambda () (set! x (* x x))))
  (s (lambda () (set! x (* x x x)))))

;; 1000000: P1 sets x to 100 and then P2 set x to 1000000.
;; 1000000: P2 set x to 1000 and then P1 sets x to 1000000.
