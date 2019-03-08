#lang racket
(provide (all-defined-out))

(require "2_68.scm")
(require "2_69.scm")

(define rock-pairs '((a 2) (boom 1) (get 2) (job 2) (na 16) (sha 3) (yip 9) (wah 1)))

(define rock-song-tree (generate-huffman-tree rock-pairs))

(define song '(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom))

(define encoded-song (encode song rock-song-tree))

;; encoded song
(print encoded-song)  ;; '(1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)
(newline)
;; bits required for the encoding
(length encoded-song)  ;; 84
;; smallest number of bits that would be needed to encode this song use a fixed-length code.
(* (length song) 3)  ;; 108
