(test (op cond?) (reg exp))
(branch (label ev-cond))

ev-cond
 (assign exp (op cond->if) (reg exp))
 (goto (label ev-if))
