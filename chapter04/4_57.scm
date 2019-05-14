#lang racket

(rule (can-replace ?person1 ?person2) 
  (and (job ?person1 ?job1)
       (job ?person2 ?job2)
       (or (same ?job1 ?job2) 
           (can-do-job ?job1 ?job2))
       (not (same ?person1 ?person2))))

;; 1. all people who can replace Cy D. Fect;
(can-replace ?person (Cy D. Fect))

;; 2. all people who can replace someone who is being paid more than they are, together with the two salaries.
(and (salary ?person-with-low-salary ?low-salary)
     (salary ?person-with-high-salary ?high-salary)
     (lisp-value < ?low-salary ?high-salary)
     (can-replace ?person-with-low-salary ?person-with-high-salary))
