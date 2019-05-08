#lang sicp

(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 
        'verb-phrase
        (parse-verb-phrase)
        (parse-prepositional-phrase))))

;; This works, but not work if we interchange the order of expressions in the amb.
;; Because the amb evaluate from left to right, after interchange the order of expressions in the amb,
;; (parse-verb-phrase) will first evaluate a subexpression that contains (parse-verb-phrase),
;; that's an infinite loop.
