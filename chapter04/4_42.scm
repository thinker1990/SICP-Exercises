#lang sicp

(define (multiple-dwelling)
  (let ((Betty (amb 1 2 3 4 5))
        (Ethel (amb 1 2 3 4 5))
        (Joan (amb 1 2 3 4 5))
        (Kitty (amb 1 2 3 4 5))
        (Mary (amb 1 2 3 4 5)))
    (require (distinct? (list Betty Ethel Joan Kitty Mary)))
    (require (xor (= Kitty 2) (= Betty 3)))  ;; Betty: “Kitty was second in the examination. I was only third.”
    (require (xor (= Ethel 1) (= Joan 2)))  ;; Ethel: “You’ll be glad to hear that I was on top. Joan was second.”
    (require (xor (= Joan 3) (= Ethel 5)))  ;; Joan: “I was third, and poor old Ethel was bottom.”
    (require (xor (= Kitty 2) (= Mary 4)))  ;; Kitty: “I came out second. Mary was only fourth.”
    (require (xor (= Mary 4) (= Betty 1)))  ;; Mary: “I was fourth. Top place was taken by Betty.”
    (list (list 'Betty Betty)
          (list 'Ethel Ethel)
          (list 'Joan Joan)
          (list 'Kitty Kitty)
          (list 'Mary Mary))))

(define (xor p q)
  (or (p (not q)) 
      (q (not p))))

;; For more detailed solution, see: https://wizardbook.wordpress.com/2011/01/12/exercise-4-42/
