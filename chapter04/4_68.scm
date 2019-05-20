
(rule (reverse () ()))
(rule (reverse (?first . ?rest) ?reversed)
      (and (reverse ?rest ?reversed-rest) 
           (append-to-form ?reversed-rest ?first ?reversed)))

(reverse (1 2 3) ?x) 
;; (reverse (1 2 3) (3 2 1))

(reverse ?x (1 2 3))
;; infinite loop

;; More elaborate answer from: https://wizardbook.wordpress.com/2012/04/19/exercise-4-68/
