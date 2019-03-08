#lang racket
(provide (all-defined-out))

(require "2_68.scm")
(require "2_69.scm")

;; n = 5
(define pairs-5 '((a 1) (b 2) (c 4) (d 8) (e 16)))
(define tree-5 (generate-huffman-tree pairs-5))
;; bits are required to encode the most frequent symbol:
(length (encode '(e) tree-5))
;; bits are required to encode the most frequent symbol:
(length (encode '(a) tree-5))

;; n = 10
(define pairs-10 (append pairs-5 '((f 32) (g 64) (h 128) (i 256) (j 512))))
(define tree-10 (generate-huffman-tree pairs-10))
;; bits are required to encode the most frequent symbol:
(length (encode '(j) tree-10))
;; bits are required to encode the most frequent symbol:
(length (encode '(a) tree-10))

;; In such a tree (for general n) how many bits are required to encode the most frequent symbol? 
n - 1
;; The least frequent symbol?
1
