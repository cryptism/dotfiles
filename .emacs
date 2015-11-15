(defvar *emacs-load-start* (current-time))
(setq dotfiles-dir (file-name-directory (or load-file-name (buffer-file-name))))
(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; Display crap
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
(global-prettify-symbols-mode +1)
;; Bootstrap
(require 'package)
(setq package-archives
      (append '(("org"  . "http://orgmode.org/elpa/")
		("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
		("melpa"        . "http://melpa.milkbox.net/packages/")
		("marmalade"    . "http://marmalade-repo.org/packages/"))
	      package-archives))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
;; My stuff first
(use-package misc
  :defer t
  :load-path "site-lisp/misc.el"
  :bind ("s-<insert>" . paste-primary-selection)
  :config (add-hook 'before-save-hook 'delete-trailing-whitespace))
;; Then the rest
(use-package ag :ensure t)
(use-package agda2 :defer t)
(use-package auctex :disabled t)
(use-package auto-complete :ensure t)
(use-package cider :defer t)
(use-package clojure-mode
  :defer t
  :config
  (require 'smartparens-config)
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode))
(use-package coffee-mode
  :defer t
  :config (setq coffee-tab-width 4))
(use-package company :ensure t :defer t)
(use-package csv-mode :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package easy-kill :ensure t)
(use-package erlang :defer t)
(use-package exec-path-from-shell :ensure t)
(use-package flycheck :ensure t)
(use-package ghc :ensure t)
(use-package go-mode :defer t)
(use-package guide-key :ensure t)
(use-package haskell-mode
  :ensure t
  :bind (("C-," . haskell-move-nested-left)
	 ("C-." . haskell-move-nested-right))
  :init
  (bind-key "C-<" '(kbd "C-u C-,"))
  (bind-key "C->" '(kbd "C-u C-."))
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  (setq haskell-font-lock-symbols t))
(use-package helm
  :ensure t
  :defer t
  :config (use-package helm-config))
(use-package imenu-anywhere
  :ensure t
  :bind ("C-c i" . imenu-anywhere))
(use-package idris-mode
  :mode "\\.idr\\'"
  :defer t)
(use-package jedi :ensure t)
(use-package js2-mode
  :defer t
  :ensure t
  :mode "\\.js\\'"
  :config
  (add-hook 'js2-mode-hook
	    (lambda () (push '("function" . ?λ) prettify-symbols-alist))))
(use-package json-mode :ensure t :defer t)
(use-package magit :ensure t)
(use-package markdown-mode :ensure t :defer t)

(use-package multiple-cursors :ensure t)
(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle))
(use-package nix-mode :ensure t :defer t)
(use-package protobuf-mode :defer t)
(use-package puppet-mode :defer t)
(use-package purescript-mode :defer t)
(use-package python-mode :ensure t :defer t)
(use-package rainbow-delimiters :ensure t)
(use-package rainbow-mode :ensure t)
(use-package rust-mode :defer t)
(use-package sh-script
  :defer t
  :mode ("\\.zsh\\'" . sh-mode)
  :config (setq sh-indentation 2 sh-basic-offset 2))
(use-package smartparens :ensure t)
(use-package scss-mode :ensure t :defer t)
(use-package tabbar :ensure t)
(use-package tidal
  :disabled t
  :after haskell-mode
  :mode ("\\.tidal\\.hs\\'" . haskell-mode)
  :load-path "~/composition/tidal/share"
  :config
  (setq tidal-interpreter "/usr/local/bin/ghci")
  (if (= (length (shell-command-to-string "ps cax | grep jackd")) 0)
      (call-process-shell-command "jackd -d coreaudio &"))
  (if (= (length (shell-command-to-string "ps cax | grep dirt")) 0)
      (sleep-for 1)
    (call-process-shell-command "cd ~/composition/bin/Dirt/dirt &")))
(use-package tuareg :defer t)
(use-package twittering-mode :ensure t :defer t)
(use-package yaml-mode :ensure t :defer t)
(use-package yasnippet :ensure t)
(use-package virtualenv :ensure t)
