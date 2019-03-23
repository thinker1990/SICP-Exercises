#lang racket

(define (cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else (error "Undefined operation: CONS" m))))
  dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
  (begin ((z 'set-car!) new-value)
         z))
(define (set-cdr! z new-value)
  (begin ((z 'set-cdr!) new-value)
         z))


(define x (cons 1 2))
;; global env:
;;   cons -> parameters: x y
;;           body: ...
;;  
;;   car -> parameters: z
;;          body: ...
;;   cdr -> parameters: z
;;          body: ...
;;   set-car! -> parameters: z new-value
;;               body: ...
;;   set-cdr! -> parameters: z new-value
;;               body: ...
;;
;;   x -> dispatch (from E1)
;; 
;; E1: (point global env)
;;   x -> 1
;;   y -> 2
;;   set-x! -> parameters: v
;;             body: ...
;;   set-y! -> parameters: v
;;             body: ...
;;   dispath -> parameters: m
;;              body: ...

(define z (cons x x))
;; global env:
;;   cons -> parameters: x y
;;           body: ...
;;  
;;   car -> parameters: z
;;          body: ...
;;   cdr -> parameters: z
;;          body: ...
;;   set-car! -> parameters: z new-value
;;               body: ...
;;   set-cdr! -> parameters: z new-value
;;               body: ...
;;
;;   x -> dispatch (from E1)
;;
;;   z -> dispatch (from E2)
;; 
;; E1: (point global env)
;;   x -> 1
;;   y -> 2
;;   set-x! -> parameters: v
;;             body: ...
;;   set-y! -> parameters: v
;;             body: ...
;;   dispath -> parameters: m
;;              body: ...
;;
;; E2: (point global env)
;;   x -> x (from global env)
;;   y -> x (from global env)
;;   set-x! -> parameters: v
;;             body: ...
;;   set-y! -> parameters: v
;;             body: ...
;;   dispath -> parameters: m
;;              body: ...

(set-car! (cdr z) 17)
;; global env:
;;   cons -> parameters: x y
;;           body: ...
;;  
;;   car -> parameters: z
;;          body: ...
;;   cdr -> parameters: z
;;          body: ...
;;   set-car! -> parameters: z new-value
;;               body: ...
;;   set-cdr! -> parameters: z new-value
;;               body: ...
;;
;;   x -> dispatch (from E1)
;;
;;   z -> dispatch (from E2)
;; 
;; E1: (point global env)
;;   x -> 17
;;   y -> 2
;;   set-x! -> parameters: v
;;             body: ...
;;   set-y! -> parameters: v
;;             body: ...
;;   dispath -> parameters: m
;;              body: ...
;;
;; E2: (point global env)
;;   x -> x (from global env)
;;   y -> x (from global env)
;;   set-x! -> parameters: v
;;             body: ...
;;   set-y! -> parameters: v
;;             body: ...
;;   dispath -> parameters: m
;;              body: ...
;;
;; E3: (point global env)
;;   z -> (cdr z) 
;;   evaluating (cdr z) generate E4
;;   -> x (from global env)
;;   -> dispath ()
;;   new-value -> 17
;;   evaluating body of set-cdr! from global env:
;;   (begin ((z 'set-car!) new-value)
;;            z)
;;   -> ((dispatch (from E1) 'set-car!) 17)
;;   generate E6
;;   -> (set-x! 17)
;;   generate E7
;;   -> no value returned, just side effect
;;   -> return x (from global env)
;; 
;; E4: (point global env)
;;   z -> z (from global env)
;;     -> dispath (from E2)
;;   evaluating body of dispatch from E2 generate E5
;;   -> x (from global env)
;;   
;; E5: (point E2)
;;   m -> 'cdr
;;   (cond ((eq? m 'car) x)
;;         ((eq? m 'cdr) y)
;;         ((eq? m 'set-car!) set-x!)
;;         ((eq? m 'set-cdr!) set-y!))
;;   -> y (from E2)
;;   -> x (from global env)
;; 
;; E6: (point E1)
;;   m -> 'set-car!
;;   (cond ((eq? m 'car) x)
;;         ((eq? m 'cdr) y)
;;         ((eq? m 'set-car!) set-x!)
;;         ((eq? m 'set-cdr!) set-y!))
;;   -> set-x! (from E1)
;; 
;; E7: (point E1)
;;   v -> 17
;;   (set! x v)
;;   x from E1 is set 17 now

(car x)  ;; 17
;; global env:
;;   cons -> parameters: x y
;;           body: ...
;;  
;;   car -> parameters: z
;;          body: ...
;;   cdr -> parameters: z
;;          body: ...
;;   set-car! -> parameters: z new-value
;;               body: ...
;;   set-cdr! -> parameters: z new-value
;;               body: ...
;;
;;   x -> dispatch (from E1)
;;
;;   z -> dispatch (from E2)
;;
;;   evaluting (car x) generate E3
;;   -> 17
;; 
;; E1: (point global env)
;;   x -> 17
;;   y -> 2
;;   set-x! -> parameters: v
;;             body: ...
;;   set-y! -> parameters: v
;;             body: ...
;;   dispath -> parameters: m
;;              body: ...
;;
;; E2: (point global env)
;;   x -> x (from global env)
;;   y -> x (from global env)
;;   set-x! -> parameters: v
;;             body: ...
;;   set-y! -> parameters: v
;;             body: ...
;;   dispath -> parameters: m
;;              body: ...
;; 
;; previous E3 ~ E7 has no use.
;; E3: (point global env)
;;   z -> x (from global env)
;;     -> dispatch (from E1)
;;   (z 'car)
;;   -> (dispath 'car)
;;   generate E4
;;   -> 17
;;
;; E4: (point E1)
;;   m -> 'car
;;   (cond ((eq? m 'car) x)
;;         ((eq? m 'cdr) y)
;;         ((eq? m 'set-car!) set-x!)
;;         ((eq? m 'set-cdr!) set-y!))
;;   -> x
;;   search from E1, that is 17
