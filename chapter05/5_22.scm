;; Solution from: http://community.schemewiki.org/?sicp-ex-5.22

;;a) 
(define append-m 
  (make-machine '() 
                (list (list 'null? null?) 
                      (list 'cdr cdr) 
                      (list 'car car) 
                      (list 'cons cons)) 
                '(controller 
                   (assign continue (label append-done)) 
                  loop 
                   (test (op null?) (reg x)) 
                   (branch (label null-x)) 
                   (save continue) 
                   (assign continue (label cdr-done)) 
                   (assign car-x (op car) (reg x)) 
                   (save car-x) 
                   (assign x (op cdr) (reg x)) 
                   (goto (label loop)) 
                  null-x 
                   (assign x (reg y)) 
                   (goto (reg continue)) 
                  cdr-done 
                   (restore car-x) 
                   (assign x (op cons) (reg car-x) (reg x)) 
                   (restore continue) 
                   (goto (reg continue)) 
                  append-done))) 
 
;;b) 
(define append-m! 
  (make-machine '() 
                (list (list 'null? null?) 
                      (list 'cdr cdr) 
                      (list 'set-cdr! set-cdr!)) 
                '(controller 
                   (assign iter-x (reg x))  
                  iter 
                   (assign cdr-x (op cdr) (reg iter-x)) 
                   (test (op null?) (reg cdr-x)) 
                   (branch (label do-append)) 
                   (assign iter-x (op cdr) (reg iter-x)) 
                   (goto (label iter)) 
                  do-append 
                   (perform (op set-cdr!) (reg iter-x) (reg y))))) 
