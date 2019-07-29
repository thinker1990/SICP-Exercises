;; Solution from: http://community.schemewiki.org/?sicp-ex-5.12

(define (make-dataset)              
  (let ((dataset '()))             
    (define (adjoin! datum) 
      (if (not (is-in-dataset? datum)) 
          (set! dataset (cons datum dataset))))                 
    (define (print) 
      (display dataset) 
      (newline)) 
    (define (is-in-dataset? datum) ; private helper function 
      (cond ((symbol? datum) (memq datum dataset)) 
            ((list? datum) (member datum dataset)) 
            (else (error "Unknown data type -- IS-IN-dataset?" datum)))) 
    (define (dispatch message) 
      (cond ((eq? message 'adjoin!) adjoin!) 
            ((eq? message 'print) (print)) 
            (else (error "Unknown operation -- DATASET" message)))) 
    dispatch)) 

(define (adjoin-to-dataset! datum dataset) 
  ((dataset 'adjoin!) datum)) 
  
(define (print-dataset dataset) 
  (dataset 'print)) 
    
; the rest of this solution "overrides" existing functions in ch5-regsim.scm 
; that is, they add a bit of functionality, then call the existing functions. 
; this way, readers (the author included) don't have to compare code 
; just to figure out what was added/changed. 
          
; implemented as a "facade" in front of the old machine 
(define (make-new-machine-5.12)              
  (let ((machine-regsim (make-new-machine-regsim)) ; "base object" or "delegate"  
        (dataset-table                                           
         (list (list 'assign (make-dataset)) 
               (list 'branch (make-dataset)) 
               (list 'goto (make-dataset)) 
               (list 'perform (make-dataset)) 
               (list 'restore (make-dataset)) 
               (list 'save (make-dataset)) 
               (list 'test (make-dataset)) 
               (list 'goto-registers (make-dataset)) 
               (list 'save-registers (make-dataset)) 
               (list 'restore-registers (make-dataset))))   
        ; register names are determined by the user, so these should be stored separately 
        ; sure, it'd take one sick cookie to name a register 'goto', 
        ; but a register named 'test' is not inconceivable. 
        ; also, a user could technically manipulate pc and flag directly 
        (assign-dataset-table 
         (list (list 'pc (make-dataset)) 
               (list 'flag (make-dataset))))) 
          
    ; "public procedures" 
    (define (allocate-register-5.12 name)         
      (set! assign-dataset-table 
            (cons  ; no duplicate checking - original regsim will crash on that anyway 
             (list name (make-dataset)) 
             assign-dataset-table))                 
      ((machine-regsim 'allocate-register) name)) 
        
    (define (lookup-dataset name) 
      (lookup-dataset-in-table name dataset-table)) 
          
    (define (lookup-assign-dataset name) 
      (lookup-dataset-in-table name assign-dataset-table))    
  
    (define (print-all-datasets) 
      (print-dataset-table dataset-table "Instructions and registers used") 
      (print-dataset-table assign-dataset-table "Assignments"))       
        
    ; "private procedures" (cannot be invoked from outside the object)  
    (define (lookup-dataset-in-table name table) 
      (let ((val (assoc name table))) 
        (if val 
            (cadr val) 
            (error "dataset not found -- GET-DATASET-FROM-TABLE" name table))))       
          
    (define (print-dataset-table table title) 
      (newline) 
      (display title) 
      (newline) 
      (for-each  
        (lambda (table-entry)  
          (display (car table-entry)) 
          (display ": ") 
          (print-dataset (cadr table-entry))) 
        table)) 
        
    ; expose public API 
    (define (dispatch message) 
      (cond                
        ; one override 
        ((eq? message 'allocate-register) allocate-register-5.12)               
        ; new messages 
        ((eq? message 'print-all-datasets) (print-all-datasets)) 
        ((eq? message 'lookup-dataset) lookup-dataset) 
        ((eq? message 'lookup-assign-dataset) lookup-assign-dataset)   
        ; punt everything else to "base class" / delegate - INCLUDING error handling 
        (else (machine-regsim message))))                          
      dispatch))    
      
(define (make-execution-procedure-5.12 inst labels machine pc flag stack ops)   
  (let ((dataset ((machine 'lookup-dataset) (car inst)))) 
        (adjoin-to-dataset! (cdr inst) dataset))     
    (make-execution-procedure-regsim inst labels machine pc flag stack ops))     
 
(define (make-goto-5.12 inst machine labels pc)  
  (let ((dest (goto-dest inst)))  ; duplicated 2 lines of supporting logic 
    (if (register-exp? dest) 
        (let ((dataset ((machine 'lookup-dataset) 'goto-registers))) 
          (adjoin-to-dataset! (register-exp-reg dest) dataset))))                  
        (make-goto-regsim inst machine labels pc)) ; punt to ch5-regsim.scm 
                        
(define (make-save-5.12 inst machine stack pc)         
  (let ((dataset ((machine 'lookup-dataset) 'save-registers))) 
        (adjoin-to-dataset! (stack-inst-reg-name inst) dataset)) 
    (make-save-regsim inst machine stack pc)) 
 
(define (make-restore-5.12 inst machine stack pc)                        
  (let ((dataset ((machine 'lookup-dataset) 'restore-registers))) 
        (adjoin-to-dataset! (stack-inst-reg-name inst) dataset)) 
    (make-restore-regsim inst machine stack pc))       
 
(define (make-assign-5.12 inst machine labels operations pc)     
  (let ((dataset ((machine 'lookup-assign-dataset) (assign-reg-name inst)))) 
        (adjoin-to-dataset! (assign-value-exp inst) dataset)) 
    (make-assign-regsim inst machine labels operations pc))         
