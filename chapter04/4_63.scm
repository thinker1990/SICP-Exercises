
(rule (grandson ?G ?S)
      (and (son ?G ?f)
           (son ?f ?S)))

(rule (son ?M ?S)
      (and (wife ?f ?M) 
           (son ?f ?S)))
