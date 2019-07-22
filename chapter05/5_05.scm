n = 2 
(save continue) ;; stack: ((label fact-done)) 
(save n)             ;;  stack: (2 (label fact-done)) 
(assign n (op -) (reg n) (const 1)) ;; n: 1;  stack: (2 (label fact-done))
(assign continue (label after-fact)) ;; continue: (label after-fact);  stack: (2 (label fact-done))
  
n = 1 
(restore n)      ;; n: 2;  stack: ((label fact-done)) 
(restore continue) ;; continue: (label fact-done);  stack: () 
