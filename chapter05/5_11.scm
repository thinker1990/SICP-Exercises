;; a. 
(controller
   (assign continue (label fib-done))
 fib-loop
   (test (op <) (reg n) (const 2))
   (branch (label immediate-answer))
   ;; set up to compute Fib(n − 1)
   (save continue)
   (assign continue (label afterfib-n-1))
   (save n)           ; save old value of n
   (assign n (op -) (reg n) (const 1)) ; clobber n to n-1
   (goto (label fib-loop)) ; perform recursive call
 afterfib-n-1 ; upon return, val contains Fib(n − 1) 
   (restore n)
   ;; set up to compute Fib(n − 2)
   (assign n (op -) (reg n) (const 2))
   (assign continue (label afterfib-n-2))
   (save val)         ; save Fib(n − 1)
   (goto (label fib-loop))
 afterfib-n-2 ; upon return, val contains Fib(n − 2)
   ;;(assign n (reg val)) ; n now contains Fib(n − 2)
   ;;(restore val)      ; val now contains Fib(n − 1)
   (restore n)        ; n now contains Fib(n - 1)
   (restore continue)
   (assign val (op +) (reg val) (reg n))  ; Fib(n − 1) + Fib(n − 2)
   (goto (reg continue))   ; answer is in val
 immediate-answer
   (assign val (reg n))   ; base case: Fib(n) = n
   (goto (reg continue))
 fib-done)

;; b.
(define (make-save inst machine stack pc)
  (let* ((reg-name (stack-inst-reg-name inst))
         (reg (get-register machine reg-name))
         (reg-value (get-contents reg)))
    (lambda () 
      (push stack (cons reg-name reg-value))
      (advance-pc pc))))
(define (make-restore inst machine stack pc)
  (let* ((reg-name (stack-inst-reg-name inst))
         (reg (get-register machine reg-name))
         (top (pop stack)))
    (lambda ()
      (if (eq? reg-name (car top))
          (set-contents! reg (cdr top))
          (error "The value is not from register:" reg-name))
      (advance-pc pc))))

;; c. Solution from: http://community.schemewiki.org/?sicp-ex-5.11
;; Allocate a stack 
(define (allocate-stack name) 
  (if (assoc name stack-table) 
      (error "Multiply defined stacks: " name) 
      (set! stack-table 
            (cons (list name (make-stack)) 
                  stack-table)))) 
;; Then when initializing machine in (make-machine ...) 
(for-each (lambda (reg-name) ;; New stack for each register 
            ((machine 'allocate-stack) reg-name)) 
          register-names) 
;; Initializing all stacks becomes this: 
(the-ops 
  (list (list 'initialize-stack 
               (lambda () 
                 (for-each (lambda (stack) (stack 'initialize)) 
                           (map cadr stack-table))))))
