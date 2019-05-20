
(rule (ends-in-grandson (grandson)))
(rule (ends-in-grandson (?x . ?rel))
      (ends-in-grandson ?rel))

(rule ((great . ?rel) ?x ?y)
      (and (ends-in-grandson ?rel) 
           (son ?x ?mid)
           (?rel ?mid ?y)))
