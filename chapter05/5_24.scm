;; Solution from: http://community.schemewiki.org/?sicp-ex-5.24

ev-cond
 (save continue)
 (assign unev (op cond-clauses) (reg exp))
ev-cond-loop
 (test (op null?) (reg unev))
 (branch (label ev-cond-unspec))
 (assign exp (op cond-first-clause-predicate) (reg unev))
 (test (op cond-else-predicate?) (reg exp))
 (branch (label ev-cond-true))
 (save unev)
 (save env)
 (assign continue (label ev-cond-decide))
 (goto (label eval-dispatch))
ev-cond-decide
 (restore env)
 (restore unev)
 (test (op true?) (reg val))
 (branch (label ev-cond-true))
 (assign unev (op cond-rest-clauses) (reg unev))
 (goto (label ev-cond-loop))
ev-cond-true
 (assign unev (op cond-first-clause-actions) (reg unev))
 (goto (label ev-sequence))
ev-cond-unspec
 (assign val (const 'unspecified))
 (restore continue)
 (goto (label continue))
