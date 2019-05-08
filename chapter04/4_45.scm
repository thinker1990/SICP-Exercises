#lang sicp

;; The answer comes from: https://wizardbook.wordpress.com/2011/01/15/exercise-4-45/
;; The 5 possible ways to parse the sentence are:

;; 1. The professor that is with the cat, lectures to the student, who is in the class
(sentence 
 (simple-noun-phrase (article the) 
                     (noun professor))
 (verb-phrase 
  (verb-phrase (verb-phrase (verb lectures) 
                            (prep-phrase (prep to) 
                                         (simple-noun-phrase (article the) 
                                                             (noun student))))
               (prep-phrase (prep in)
                            (simple-noun-phrase (article the) (noun class))))
  (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))

;; 2. The professor lectures to the student, who is in the class with the cat 
(sentence 
 (simple-noun-phrase (article the) (noun professor)) 
 (verb-phrase (verb-phrase (verb lectures) 
                           (prep-phrase (prep to) (simple-noun-phrase (article the) (noun student))))
              (prep-phrase (prep in) 
                           (noun-phrase (simple-noun-phrase (article the) 
                                                            (noun class)) 
                                        (prep-phrase (prep with) 
                                                     (simple-noun-phrase (article the) 
                                                                         (noun cat)))))))

;; 3. The professor and the cat together, lecture to the student in the class
(sentence 
 (simple-noun-phrase (article the) 
                     (noun professor)) 
 (verb-phrase (verb-phrase (verb lectures)
                           (prep-phrase (prep to) 
                                        (noun-phrase (simple-noun-phrase (article the)
                                                                         (noun student)) 
                                                     (prep-phrase (prep in) 
                                                                  (simple-noun-phrase (article the)
                                                                                      (noun class))))))
              (prep-phrase (prep with) 
                           (simple-noun-phrase (article the) 
                                               (noun cat)))))

;; 4. The professor, lectures only to the student with the cat, that is in the class
(sentence 
 (simple-noun-phrase (article the)
                     (noun professor)) 
 (verb-phrase (verb lectures) 
              (prep-phrase (prep to) 
                           (noun-phrase (noun-phrase (simple-noun-phrase (article the) 
                                                                         (noun student)) 
                                                     (prep-phrase (prep in)
                                                                  (simple-noun-phrase (article the) 
                                                                                      (noun class)))) 
                                        (prep-phrase (prep with)
                                                     (simple-noun-phrase (article the)
                                                                         (noun cat)))))))

;; 5. The professor lectures to the student, in the class that has the cat
(sentence 
 (simple-noun-phrase (article the)
                     (noun professor)) 
 (verb-phrase (verb lectures) 
              (prep-phrase (prep to)
                           (noun-phrase (simple-noun-phrase (article the) 
                                                            (noun student)) 
                                        (prep-phrase (prep in) 
                                                     (noun-phrase (simple-noun-phrase (article the)
                                                                                      (noun class))
                                                                  (prep-phrase (prep with)
                                                                               (simple-noun-phrase (article the)
                                                                                                   (noun cat)))))))))
