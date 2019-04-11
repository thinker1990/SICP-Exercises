#lang sicp

(define (pairs s t)
  (interleave
    (stream-map (lambda (x) (list (stream-car s) x)) 
                t)
    (pairs (stream-cdr s) (stream-cdr t))))

;; Louis' implementation will recurse infinitely simply because interleave is an ordinary function, not a special form like cons-stream, 
;; and hence will need to fully evaluate both arguments first, since Scheme uses eager evaluation for ordinary functions. 
;; Since the second argument to interleave is a recursive call to pairs, and there is no hard-coded base case, this implementation will recurse infinitely.
;; 
;; This brilliant answer comes from by xdavidliu: http://community.schemewiki.org/?sicp-ex-3.68
