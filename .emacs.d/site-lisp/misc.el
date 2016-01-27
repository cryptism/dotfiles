;;; package --- summary
;;; Commentary:
;;; Code:
(defun paste-primary-selection ()
  "Urxvt-style keyboard yanking."
  (interactive)
  (insert (x-get-selection 'PRIMARY)))

(provide 'misc)
;;; misc.el ends here
