#lang racket

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


;; test cases
(define empty-tree '())
(define (make-leaf entry) (make-tree entry empty-tree empty-tree))

(define tree1 (make-tree 7 (make-tree 3 (make-leaf 1) 
                                        (make-leaf 5)) 
                           (make-tree 9 empty-tree 
                                        (make-leaf 11))))

(define tree2 (make-tree 3 (make-leaf 1) 
                           (make-tree 7 (make-leaf 5) 
                                        (make-tree 9 empty-tree 
                                                     (make-leaf 11)))))

(define tree3 (make-tree 5 (make-tree 3 
                                      (make-leaf 1) 
                                      empty-tree) 
                           (make-tree 9 (make-leaf 7) 
                                        (make-leaf 11))))

(tree->list-1 tree1)  ;; '(1 3 5 7 9 11)
(tree->list-2 tree1)  ;; '(1 3 5 7 9 11)

(tree->list-1 tree2)  ;; '(1 3 5 7 9 11)
(tree->list-2 tree2)  ;; '(1 3 5 7 9 11)

(tree->list-1 tree3)  ;; '(1 3 5 7 9 11)
(tree->list-2 tree3)  ;; '(1 3 5 7 9 11)

;; a. The two procedures produce the same result for every tree.
;; 
;; Solution from: https://wizardbook.wordpress.com/2010/12/07/exercise-2-63/
;; b. tree->list-1 visits each tree item once and at each visit it uses append so its growth is O(n . append) 
;;    assuming a balanced tree then append will be O(n/2 + n/4 + n/8 …) = O(log n)
;;    So tree->list-1 is O(n log n)
;; 
;;    tree->list-2 visits each tree item once and at each visit it uses cons 
;;    So its growth is O(1.n) = O(n)
