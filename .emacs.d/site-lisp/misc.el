; urxvt-style keyboard yanking
(defun paste-primary-selection ()
  (interactive)
  (insert (x-get-selection 'PRIMARY)))
