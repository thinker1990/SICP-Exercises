#lang sicp

;; 1. newline and display are both primitive procedure that would force the expressions in a sequence.

;; 2. (p1 1)  original version: (1, 2)    Cy’s version: (1, 2)
;;    (p2 1)  original version: 1         Cy’s version: (1, 2)

;; 3. Cy’s evaluator works identically to the original evaluator in example a 
;;    because the lambda has the primitive procedure display which always causes any thunk to be forced.

;; 4. For more elaborate answer, see: https://wizardbook.wordpress.com/2011/01/06/exercise-4-30/
