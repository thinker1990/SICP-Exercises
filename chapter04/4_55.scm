#lang racket

;; 1. all people supervised by Ben Bitdiddle;
(supervisor ?name (Ben Bitdiddle))

;; 2. the names and jobs of all people in the accounting division;
(job ?name (accounting . ?job))

;; 3. the names and addresses of all people who live in Slumerville.
(address ?name (Slumerville . ?address))
