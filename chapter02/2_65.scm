#lang racket

(define (union-set set1 set2) 
  (list->tree 
    (union-set-for-ordered-list (tree->list-2 set1) 
                                (tree->list-2 set2))))

(define (intersection-set set1 set2) 
  (list->tree 
    (intersection-set-for-ordered-list (tree->list-2 set1)
                                       (tree->list-2 set2))))


;; 1. tree->list-2 comes from Exercise 2.63 with order of growth O(n)
;; 2. list->tree comes from Exercise 2.64 with order of growth O(n)
;; 3. union-set-for-ordered-list come from Exercise 2.62 with order of growth O(n)
;; 4. intersection-set-for-ordered-list come from section "Sets as ordered lists" 
;;    with order of growth O(n)
;; so, the order of growth of union-set and intersection-set here are both still O(n).
