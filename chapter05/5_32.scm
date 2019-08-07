;; Solution from: http://community.schemewiki.org/?sicp-ex-5.32

;; (a) 
ev-application 
  (save continue) 
  (assign unev (op operands) (reg exp)) 
  (assign exp (op operator) (reg exp)) 
  (test (op symbol?) (reg exp))                    ;; is the operator is symbol? 
  (branch (label ev-appl-operator-symbol)) 
  (save env) 
  (save unev) 
  (assign continue (label ev-appl-did-operator)) 
  (goto (label eval-dispatch)) 
ev-appl-operator-symbol 
  (assign continue (label ev-appl-did-operator-no-restore)) 
  (goto (label eval-dispatch)) 
ev-appl-did-operator 
  (restore unev)             
  (restore env) 
ev-appl-did-operator-no-restore 
  (assign argl (op empty-arglist)) 
  (assign proc (reg val))     ; the operator 
  (test (op no-operands?) (reg unev)) 
  (branch (label apply-dispatch)) 
  (save proc) 

;; (b) 
;; It won't get all the advantage of compiler, because the interpreter need parse the code every time when it run. 
;; and  recognizing the special case will make the code more complicated. 
