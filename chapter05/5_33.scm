;; In (* (factorial (- n 1) n)), compiler need (save argl), then (restore argl). 
;; In (* n (factorial (- n 1))), compiler need (save env), then (restore env). 
;; so there is no efficiency between the two program.
