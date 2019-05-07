#lang sicp

(define (multiple-dwelling)
  (let ((Mary (amb 'Moore 'Downing 'Hall 'Hood 'Parker))
        (Gabrielle (amb 'Moore 'Downing 'Hall 'Hood 'Parker))
        (Lorna (amb 'Moore 'Downing 'Hall 'Hood 'Parker))
        (Rosalind (amb 'Moore 'Downing 'Hall 'Hood 'Parker))
        (Melissa (amb 'Moore 'Downing 'Hall 'Hood 'Parker)))
    (require (eq? Mary 'Moore))  ;; Mary Ann Moore’s father is Moore
    (require (eq? Melissa 'Hood))  ;; The Melissa, is named after Hood’s daughter.
    (require (not (eq? Gabrielle 'Hood)))  ;; Hood’s yacht is the Gabrielle
    (require (not (eq? Lorna 'Moore)))  ;; Mr. Moore owns the Lorna
    (require (not (eq? Rosalind 'Hall)))  ;; Mr. Hall the Rosalind
    (require (not (eq? Melissa 'Downing)))  ;; The Melissa, owned by Colonel Downing
    (require (not (eq? Mary 'Parker))) ;; Gabrielle’s father owns the yacht that is named after Parker’s daughter.
    (require (distinct? (list Mary Gabrielle Lorna Rosalind Melissa)))
    (list 'Lorna Lorna)))
