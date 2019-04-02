#lang sicp

;; 1. by using serialized-exchange, the exchange process of the two accounts will be atomical.
;;    no matter how many accounts involved or how many exchange processed, the balance value won't change,
;;    but in some order among all accounts.
;; 2. consider (parallel-execute 
;;               (exchange account1 account2)
;;               (exchange account2 account3))
;;    diff of account1(10) and account2(20) is -10
;;    diff of account2(20) and account3(30) is -10
;;    account1 withdraw -10 -> account1: 20
;;    account2 withdraw -10 -> account2: 30
;;    account2 deposit -10 -> account2: 20
;;    account3 deposit -10 -> account3: 20
;; 3. the withdraw and deposit amount of two account in exchange is the same,
;;    and withdraw and deposit of each account is atomical, so the sum of the two
;;    accounts of exchange is fixed even the exchange itself is not atomical. 
