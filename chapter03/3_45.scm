#lang sicp

;; Answer from: https://wizardbook.wordpress.com/2010/12/19/exercise-3-45/
;; 
;; If s1 is account1’s serialiser and s2 is account2’s serialiser, then exchange is called from an environment protected by both s1 and s2. 
;; Within that environment a call to ((account1 'withdraw) difference) is made which will use s1 call (withdraw difference), 
;; however s1 is already protecting the call to exchange and so withdraw can’t be evaluated until exchange has completed which will never complete.
