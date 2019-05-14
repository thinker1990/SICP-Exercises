#lang racket

;; 1. the names of all people who are supervised by Ben Bitdiddle, together with their addresses;
(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?where))

;; 2. all people whose salary is less than Ben Bitdiddle’s, together with their salary and Ben Bitdiddle’s salary;
(and (salary (Bitdiddle Ben) ?Ben-amount)
     (salary ?person ?amount)
     (lisp-value < ?amount ?Ben-amount))

;; 3. all people who are supervised by someone who is not in the computer division, together with the supervisor’s name and job.
(and (job ?supervisor ?job)
     (not (job ?supervisor (computer . ?title)))
     (supervisor ?subordinate ?person))
