
(define (parse-word word-list)
  (requires (not (null? *unparsed*)))
  (require (memq (car *unparsed*) 
                 (cdr word-list)))
  (let ((found-word (random-item word-list)))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word)))

(define (random-item items)
 (if (null? items)
     (amb)
     (amb (car items)
          (random-items (cdr items)))))
