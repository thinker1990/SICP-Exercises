#lang sicp

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))


;; a
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

;; test cases
(define b1 (make-branch 1 2))
(define b2 (make-branch 1 5))
(define m1 (make-mobile b1 b2))
(define b3 (make-branch 2 m1))
(define m2 (make-mobile b1 b3))
(branch-length (left-branch m1))  ;; 1
(branch-structure (right-branch m1))  ;; 5
(branch-structure (right-branch (branch-structure (right-branch m2))))  ;; 5


;; b
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile)) 
     (branch-weight (right-branch mobile))))

(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (not (pair? structure))
        structure
        (total-weight structure))))

;; test cases
(total-weight m1)  ;; 2 + 5 = 7
(total-weight m2)  ;; 2 + 7 = 9


;; c
(define (balanced-mobile? mobile)
  (define (torque branch) 
    (* (branch-length branch) (branch-weight branch)))
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (= (torque left) (torque right))
         (balanced-structure? (branch-structure left))
         (balanced-structure? (branch-structure right)))))

(define (balanced-structure? structure)
  (if (not (pair? structure))
      #t
      (balanced-mobile? structure)))

;; test cases
(balanced-mobile? m1)  ;; #f
(balanced-mobile? m2)  ;; #f
(define b4 (make-branch 2 6))
(define b5 (make-branch 3 4))
(define m3 (make-mobile b4 b5))
(balanced-mobile? m3)  ;; #t
(define b6 (make-branch 5 m3))
(define m4 (make-mobile b6 b6))
(balanced-mobile? m4)  ;; #t


;; d
;; Only right-branch and branch-structure need to change to convert to the new representation.
(define (right-branch-new mobile)
  (cdr mobile))

(define (branch-structure-new branch)
  (cdr branch))
