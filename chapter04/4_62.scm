
(rule (last-pair (?last) (?last)))
(rule (last-pair (?u . ?v) (?last))
      (last-pair ?v (?last)))

(last-pair (3) ?x)
;; (last-pair (3) (3))
 
(last-pair (1 2 3) ?x)
;; (last-pair (1 2 3) (3))
 
(last-pair (2 ?x) (3))
;; (last-pair (2 3) (3))

;; (last-pair ?x (3)) is not possible to solve – there are an infinite number of solutions.
