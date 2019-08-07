;; Answer from: http://community.schemewiki.org/?sicp-ex-5.31

;; (f 'x 'y)  => all the saves are not necessary. 
;; ((f) 'x 'y) => not necessary too, although (f) is a compound-procedure, it will change the env register to the status where f is defined, but it will not affect the quoted 'x and 'y. 
;; (f (g 'x) y) => proc and argl are necessary, save env before eval (g 'x) is necessary too, it will change the env register and y will be affected. 
;; (f (g 'x) 'y) => proc and argl is necessary, but no need to save env before eval (g 'x) cause 'y is quoted, it will not fetch any value in the env, and env register will be reset to the status where f is defined 
