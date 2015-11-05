(defvar *emacs-load-start* (current-time))

(setq dotfiles-dir (file-name-directory
		    (or load-file-name (buffer-file-name))))

(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(eval-when-compile
  (require 'package)
  (setq package-archives
	(append '(("org"  . "http://orgmode.org/elpa/")
		  ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
		  ("melpa"        . "http://melpa.milkbox.net/packages/")
		  ("marmalade"    . "http://marmalade-repo.org/packages/"))
		package-archives))

  (package-initialize)

  (setq package-list '(ag
		       ansible
		       auctex
		       auto-complete
		       clojure-mode
		       cider
		       coffee-mode
		       company
		       csv-mode
		       dockerfile-mode
		       easy-kill
		       erlang
		       exec-path-from-shell
		       flycheck
		       ghc
		       go-mode
		       guide-key
		       haskell-mode
		       helm
		       idris-mode
		       jedi
		       js2-mode
		       json-mode
		       magit
		       markdown-mode
		       multiple-cursors
		       neotree
		       nix-mode
		       php-mode
		       protobuf-mode
		       puppet-mode
		       purescript-mode
		       pymacs
		       python-mode
		       rainbow-delimiters
		       rainbow-mode
		       ruby-mode
		       rust-mode
		       scss-mode
		       tabbar
		       tuareg
		       twittering-mode
		       use-package
		       yaml-mode
		       yasnippet
		       virtualenv))
  ;to reload: `rm -rf ~/.emacs.d/elpa`
  (unless package-archive-contents
    (package-refresh-contents))

  (dolist (package package-list)
    (unless (package-installed-p package)
      (package-install package)))

  (require 'use-package))
(use-package tidal
  :mode "\\.tidal.hs\\'"
  :load-path "~/composition/tidal/share"
  :config
  (setq tidal-interpreter "/usr/local/bin/ghci")
  (if (= (length (shell-command-to-string "ps cax | grep jackd")) 0)
      (call-process-shell-command "jackd -d coreaudio &"))
  (if (= (length (shell-command-to-string "ps cax | grep dirt")) 0)
      (sleep-for 1)
    (call-process-shell-command "cd ~/composition/bin/Dirt && ./dirt &")))

(use-package haskell-mode
  :bind
  ("C-," . haskell-move-nested-left)
  ("C-." . haskell-move-nested-right)
  :config
  (bind-key "C-<" (kbd "C-u C-,")) ;obviously depends on prev binding
  (bind-key "C->" (kbd "C-u C-.")) ;obviously depends on prev binding
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  (setq haskell-font-lock-symbols t))

(use-package coffee-mode
  :config (setq coffee-tab-width 4))

(use-package neotree
  :bind ([f8] . neotree-toggle))


; package config-Agda
;(load-file (let ((coding-system-for-read 'utf-8))
;         (shell-command-to-string "agda-mode locate")))

; formatting preferences

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
; urxvt-style keyboard yanking
(defun paste-primary-selection ()
  (interactive)
  (insert (x-get-selection 'PRIMARY)))
(global-set-key (kbd "S-<insert>") 'paste-primary-selection)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; display crap

(setq-default yank-excluded-properties 't)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq vc-follow-symlinks t)
(scroll-bar-mode -1)
(set-frame-parameter (selected-frame) 'alpha '(85 70))
(setq inhibit-startup-screen t)
(setq mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)
(load-theme 'wheatgrass)
