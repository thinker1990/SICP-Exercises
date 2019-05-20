
(rule (outranked-by ?staff-person ?boss)
  (or (supervisor ?staff-person ?boss)
      (and (outranked-by ?middle-manager
                         ?boss)
           (supervisor ?staff-person 
                       ?middle-manager))))


(outranked-by (Bitdiddle Ben) ?who)
;; query (outranked-by (Bitdiddle Ben) ?who), after unifying the conclusion of rule. 
;; we will evaluate (outranked-by ?middle-manager ?boss), this will query (outranked-by ?staff-person ?boss) again, 
;; so it will be in infinite loop.  
