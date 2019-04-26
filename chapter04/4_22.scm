#lang sicp

(define (analyze-let exp)
  (analyze-application (let->combination exp)))
