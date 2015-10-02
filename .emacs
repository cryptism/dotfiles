(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(package-initialize)
;uwsgi-style keyboard yanking
(defun paste-primary-selection ()
  (interactive)
  (insert (x-get-selection 'PRIMARY)))
(global-set-key (kbd "S-<insert>") 'paste-primary-selection)

(tool-bar-mode -1)
(menu-bar-mode -1)
(setq vc-follow-symlinks t)
(scroll-bar-mode -1)
(set-frame-parameter (selected-frame) 'alpha '(85 70))

(setq mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)

(setq package-list
      '(use-package
	multiple-cursors
	guide-key
	neotree
	auctex
	jedi
	dockerfile-mode
	magit
	easy-kill
	ag
	ansible
	clojure-mode
	cider
	coffee-mode
	haskell-mode
	;structured-haskell-mode
	tuareg
	rainbow-mode
	rainbow-delimiters
	python-mode
	nix-mode
	csv-mode
	markdown-mode
	js2-mode
	json-mode
	ghc
	erlang
	yaml-mode
	idris-mode
	purescript-mode
	tabbar
	twittering-mode
	virtualenv
	rust-mode))

(unless package-archive-contents
  (package-refresh contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq-default yank-excluded-properties 't)

(eval-when-compile
    (require 'use-package))

(use-package haskell-mode
  :init
  (bind-key "C-," 'haskell-move-nested-left)
  (bind-key "C-." 'haskell-move-nested-right)
  (bind-key "C-<" (kbd "C-u C-,")) ;obviously depends on prev binding
  (bind-key "C->" (kbd "C-u C-.")) ;obviously depends on prev binding
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))

; Add back in til I know what I'm doing
;(use-package tidal-mode
;  :mode "\\.tidal.hs\\'"
;  :init
;  (setq load-path (cons "~/composition/tidal/share" load-path))
;  (require 'tidal)
;  (setq tidal-interpreter "/usr/local/bin/ghci")
;  ;o
;  (if (= (length (shell-command-to-string "ps cax | grep jackd")) 0)
;      (call-process-shell-command "jackd -d coreaudio &"))
;  (when (= (length (shell-command-to-string "ps cax | grep dirt")) 0)
;    (sleep-for 1)
;    (call-process-shell-command "cd ~/composition/bin/Dirt && ./dirt &")))

(use-package coffee-mode
  :config (custom-set-variables '(coffee-tab-width 4)))
(use-package clojure-mode)
(use-package cider)

(custom-set-variables
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(inhibit-startup-screen t))
