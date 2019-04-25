#lang sicp

;; 1.
;; (letrec ((⟨var₁⟩ ⟨exp₁⟩) … (⟨varₙ⟩ ⟨expₙ⟩))
;;   ⟨body⟩)
;; =>
;; (let ((⟨var₁⟩ '*unassigned*)
;;       (⟨varₙ⟩ '*unassigned*))
;;     (set! ⟨var₁⟩ ⟨exp₁⟩)
;;     (set! ⟨varₙ⟩ ⟨expₙ⟩)
;;     ⟨body⟩)

(define (letrec? exp)
  (tagged-list? exp 'letrec))
(define (letrec-initials exp)
  (cadr exp))
(define (letrec-body exp)
  (cddr exp))

(define (letrec->let exp)
  (let* ((initials (letrec-initials exp))
         (body (letrec-body exp))
         (vars (map car initials))
         (exps (map cadr initials))
         (init-vars (map initial-var vars))
         (set-vars (map set-var vars exps))
         (let-body (append set-vars body)))
    (make-let init-vars let-body)))

;; 2.
;; Answer from: http://community.schemewiki.org/?sicp-ex-4.20

;; The lambda in `let is evaluated in the context of the enclosing environment, 
;; in which the bindings of the lambda itself are not in place. 
 
;; The trick of encoding `letrec is that we first establish the bindings, and 
;; then define the lambdas in an environment where the bindings are there, so 
;; the recursive call can succeed. 
 
;; The following snippets illustrate the difference: 
(let ((fact <fact-exp>)) 
  <let-body>) 
 
;; is encoded by 
((lambda (fact) 
   <let-body>) 
 <fact-exp>) 
 
;; such that `<fact-exp> can't refer to `fact. While: 
(letrec ((fact <fact-exp>)) 
  <let-body>) 
 
;; is encoded by 
((lambda (fact) 
   (set! fact <fact-exp>) 
   <let-body>) 
 '*unassigned*) 
 
;; note that in the context of `<fact-exp>, the variable `fact itself is 
;; bound (to '*unassigned*). 
