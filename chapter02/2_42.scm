#lang racket  ;; sicp package doesn't implement filter, accumulate.


(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low
            (enumerate-interval (+ low 1) high))))

(define (accumulate op init seq)
  (foldr op init seq))

(define (flatmap op seq)
  (accumulate append '() (map op seq)))


(define (queens board-size)
  (define (queen-cols k) 
    (if (= k 0)
        (list empty-board)
        (filter (lambda (positions) (safe? k positions))
                (flatmap (lambda (rest-of-queens) 
                           (map (lambda (new-row) 
                                  (adjoin-position new-row k rest-of-queens))
                                (enumerate-interval 1 board-size)))
                          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (borad-position col row)
  (cons col row))

(define (position-col position)
  (car position))

(define (position-row position)
  (cdr position))

(define empty-board (list))

(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list (borad-position k new-row))))

(define (safe? k positions)
  (if (= k 0)
      #t
      (let ((k-position (list-ref positions (- k 1)))
            (rest-queens (filter (lambda (p) (< (position-col p) k)) positions)))
        (and (not-same-row k-position rest-queens) 
             (not-same-diagonal k-position rest-queens)))))

(define (not-same-row position rest-queens)
  (accumulate (lambda (x y) (and x y)) 
              #t 
              (map (lambda (queen) 
                     (not (= (position-row queen) 
                             (position-row position)))) 
                   rest-queens)))

(define (not-same-diagonal position rest-queens)
  (accumulate (lambda (x y) (and x y)) 
              #t 
              (map (lambda (queen) (not (is-diagonal queen position))) 
                   rest-queens)))

(define (is-diagonal pos1 pos2)
  (= (abs (- (position-col pos1) (position-col pos2))) 
     (abs (- (position-row pos1) (position-row pos2)))))                   

  
;; test cases
(queens 8)
(length (queens 8))  ;; 92
