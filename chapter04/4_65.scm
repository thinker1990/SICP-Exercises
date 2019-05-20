(rule (wheel ?person)
      (and (supervisor ?middle-manager 
                       ?person)
           (supervisor ?x ?middle-manager)))

;; That's because there are four middle-manager  whose manager is Warbucks Oliver. 
;; More elaborate answer from: https://wizardbook.wordpress.com/2011/02/01/exercise-4-65/
