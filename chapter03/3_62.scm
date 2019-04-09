#lang sicp

(define (div-series s1 s2)
  (let ((factor (/ 1 (stream-car s2))))
    (define num (scale-stream factor s1))
    (define den (scale-stream factor s2))
    (mul-series num (invert-unit-series den))))

(define tangent-series (div-series sine-series cosine-series))
