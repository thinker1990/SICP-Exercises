#lang sicp

(define a (make-connector))
(define b (make-connector))
;; global env:
;;   a -> me (from E1)
;;   for-each-except -> parameters: exception procedure list
;;                      body: ...
;;   set-value! -> parameters: connector new-value informant
;;                 body: ...
;;   other procedure...
;;   
;; E1 (point global env):
;;   value -> #f
;;   informant -> #f
;;   constraints -> '()
;;   set-my-value -> lambda ...
;;   forget-my-value -> lambda ...
;;   connect -> lambda ...
;;   me -> lambda ...


(set-value! a 10 'user)
;; global env:
;;   a -> me (from E1)
;;   for-each-except -> parameters: exception procedure list
;;                      body: ...
;;   set-value! -> parameters: connector new-value informant
;;                 body: ...
;;   other procedure...
;;   
;; E1 (point global env):
;;   value -> 10
;;   informant -> 'user
;;   constraints -> '()
;;   set-my-value -> lambda ...
;;   forget-my-value -> lambda ...
;;   connect -> lambda ...
;;   me -> lambda ...
;; 
;; E2 (point global env):
;;   connector -> a (from global env)
;;             -> me (from E1)
;;   new-value -> 10
;;   informant -> 'user
;;   evaluate body of set-value! generate E3
;;   ((connector 'set-value!) 
;;    new-value 
;;    informant)
;;   -> (set-my-value 10 'user)
;;   generate E4
;;   return 'done
;;   
;; E3 (point E1):
;;   request -> 'set-value!
;;   evaluate body of me return:
;;   set-my-value
;;
;; E4 (point E1):
;;   newval -> 10
;;   setter -> 'user
;;   evaluate body of set-my-value:
;;   (cond ((not (has-value? me))
;;          (set! value newval)
;;          (set! informant setter)
;;          (for-each-except 
;;           setter
;;           inform-about-value
;;           constraints))
;;         ((not (= value newval))
;;          (error "Contradiction" 
;;                 (list value newval)))
;;         (else 'ignored))
;;   -> set value of E1 to 10
;;   -> set informant of E1 to 'user
;;   -> (for-each-except 'user inform-about-value '())
;;   generate E5
;;   return 'done
;; 
;; E5 (point global env):
;;   exception -> 'user
;;   procedure -> inform-about-value
;;   list -> '()
;;   evaluate body of for-each-except:
;;   (cond ((null? items) 'done)
;;         ((eq? (car items) exception) 
;;          (loop (cdr items)))
;;         (else (procedure (car items))
;;               (loop (cdr items))))
;;   
;;   Note: for conciseness, here ignore the environment 
;;   of inner procedure of for-each-except
;;   
;;   return: 'done
