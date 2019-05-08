#lang sicp

;; That's because function parse-word handles *unparsed* from left to right. 
;; If evaluation has other order, it will conflict with parse-word. 
