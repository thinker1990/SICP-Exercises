 ;; The difference is in (* n (factorial (- n 1))), before call (factorial (- n 1)), compiler need save continue, then restore it. 
 ;; But in iter, just (goto (reg val)), there is no need to callback. 
 