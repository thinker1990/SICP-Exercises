#lang racket

;; ''abracadabra -> (quote 'abracadabra)
;;               -> (list ('quote 'abracadabra))
;; so:
(car ''abracadabra)  ;; 'quote
(cdr ''abracadabra)  ;; '(abracadabra)
