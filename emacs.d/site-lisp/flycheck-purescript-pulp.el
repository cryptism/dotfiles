;;; package --- Summary
;;; Code:
;;; Commentary:

(flycheck-define-checker purescript-pulp
  :command ("pulp" "--monochrome" "build")
  :error-patterns
  ((error line-start
	  (or (and (zero-or-more " ") "Error at " (file-name)    " line " line ", column " column (zero-or-more " ") (or ":" "-") (zero-or-more not-newline))
	      (and "\""        (file-name) "\" (line " line ", column " column "):"))
	  (or (message (one-or-more not-newline))
	      (and (or "\r" "\n" "\r\n")
		   (message
		    (zero-or-more " ") (one-or-more not-newline)
		    (zero-or-more (or "\r" "\n")
				  (zero-or-more " ")
				  (one-or-more not-newline)))))
	  line-end))
  :modes purescript-mode)
(add-to-list 'flycheck-checkers 'purescript-pulp)

(provide 'flycheck-purescript-pulp)
;;; flycheck-purescript-pulp ends here
