#lang sicp

(lambda ⟨vars⟩
  (define u ⟨e1⟩)
  (define v ⟨e2⟩)
  ⟨e3⟩)

;; outer lambda env: 
;;   u -> e1
;;   v -> e2
;;   evaluate e3

(lambda ⟨vars⟩
  (let ((u '*unassigned*)
        (v '*unassigned*))
    (set! u ⟨e1⟩)
    (set! v ⟨e2⟩)
    ⟨e3⟩))

;; let would be transformed to lambda expression,
;; when evaluating e3, the interpreter will extend environment.
;; outer lambda env:
;;   inner lambda env:
;;     u -> e1
;;     v -> e2
;;     evaluate e3

;; A more elaborate answer from: https://wizardbook.wordpress.com/2011/01/03/exercise-4-17/
