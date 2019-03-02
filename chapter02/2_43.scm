#lang sicp


;; Solution from: http://community.schemewiki.org/?sicp-ex-2.43
;; 
;; Exchanging the order of the mapping in the flatmap results in queen-cols being re-evaluated for every item in (enumerate-interval 1 board-size). 
;; Therefore the whole work has to be duplicated board-size times at every recursion level. Since there are always board-size recursions this means that 
;; the whole work will be duplicated bord-size^board-size times.
;; Therefore if the function would take T time to run for board-size=8 with correct ordering, with the interchanged ordering it will take (8^8)T to run.
