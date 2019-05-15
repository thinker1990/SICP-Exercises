#lang racket

(rule (big-shot ?manager ?division)
      (and (job ?manager (?division . ?x-title))
           (or (not (supervisor ?manager ?boss))
               (and (supervisor ?manager ?boss) 
                    (not (job ?boss (?division . ?y-title)))))))
