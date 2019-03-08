#lang racket

;; the order of growth (as a function of n) of the number of steps 
;; needed to encode the most frequent symbol in the alphabet.
;; It is number of steps needed to search the symbol list at root node and second level node, 
;; that is: n + (n - 1) ~ O(n)
;; 
;; the order of growth (as a function of n) of the number of steps 
;; needed to encode the least frequent symbol in the alphabet.
;; It is number of steps needed to search the symbol list at each node encountered till the lowest leaf.
;; that is: n + (n - 1) + ... + 1 ~ O(n**2)
