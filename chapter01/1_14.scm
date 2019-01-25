#lang sicp

;; Solution from: https://voom4000.wordpress.com/2015/08/11/sicp-exercise-1-14/
;; You can find a counting coin tree elsewhere. Its form depends on the number of kinds of coins n, 
;; the amount of money a and denominations d_1,...,d_n. 
;; In simple terms, both processes try to build a sum \sum_{i=1}^n k_i d_i by incrementing indices k_i starting from zero values. 
;; When this sum equals to the amount, this is a way of money change. As this sum becomes larger than the amount, this is wrong way, 
;; and the process does not increase indices further and tries the other combination of index values. 
;; Now let’s see how the number of all tries depends on the amount a. I will ignore the issues of rounding to integer values, 
;; they are irrelevant to final results. The range of index k_1 is a/d_1, and it is proportional to a. 
;; The range of index k_2 is (a-k_1 d_1)/d_2. The number of pairs (k_1, k_2) grows as a^2. 
;; When we add next index, k_3, its range is (a-k_1 d_1-k_2 d_2)/d_3 and the number of tuples (k_1, k_2, k_3) is proportional to a^3. 
;; We conclude that time ~ O(a^n). 
;; The ranges of indices k_i grow proportionally to a, so space ~ O(a). 
