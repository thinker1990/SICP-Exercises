(define expt-machine 
  (make-machine 
   '(b n continue val) 
   (list (list '= =) (list '- -) (list '* *))
   '((assign continue (label expt-done)) 
     expt-loop  
      (test (op =) (reg n) (const 0))   
      (branch (label base-case))   
      (save continue)     
      (assign n (op -) (reg n) (const 1))      
      (assign continue (label after-expt))
      (goto (label expt-loop))  
     after-expt           
      (restore continue)  
      (assign val (op *) (reg b) (reg val))   
      (goto (reg continue)) 
     base-case                
      (assign val (const 1))               
      (goto (reg continue))                
     expt-done)))

(set-register-contents! expt-machine 'b 2)  ;; done
(set-register-contents! expt-machine 'n 5)  ;; done
(start expt-machine)  ;; done
(get-register-contents expt-machine 'val)  ;; 32
