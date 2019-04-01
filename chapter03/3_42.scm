#lang sicp

;; An interesting answer from: http://community.schemewiki.org/?sicp-ex-3.42
;;
;; The only difference between original and the modified version is 
;; each call to withdraw of original version create a new serialized procedure,
;; while for the modified version, it calls the same serialized protected-withdraw procedure,
;; and I just don't know weather it is saft to parallel execute the same serialized procedure.
