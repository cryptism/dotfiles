;;; Package --- Summary
;;; Commentary:
;;; Code:
(defvar *emacs-load-start* (current-time))
(defvar dotfiles-dir)
(setq dotfiles-dir
  (file-name-directory (or load-file-name (buffer-file-name))))
(prefer-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

;; Bootstrap
(require 'package)
(setq package-archives
  (append '(("org" . "http://orgmode.org/elpa/")
	    ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
	    ("melpa" . "http://melpa.milkbox.net/packages/")
	    ("marmalade" . "http://marmalade-repo.org/packages/"))
	  package-archives))
(package-initialize)

(setq vc-follow-symlinks t)
(setq-default yank-excluded-properties 't)
(setq column-number-mode t)
(setq inhibit-startup-screen t)
(defvar mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)
(setq ring-bell-function #'ignore)

;; Display crap

(tool-bar-mode 0)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-frame-parameter (selected-frame) 'alpha '(85 70))
(set-face-attribute 'default nil :family "Hasklig")
(load-theme 'wheatgrass)
(global-prettify-symbols-mode +1)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
;; My stuff first
(use-package misc
  :defer t
  :after exec-path-from-shell
  :load-path "site-lisp/misc.el"
  :bind (("s-<insert>" . paste-primary-selection)
	 ([f1] . shell))
  :config
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  ;; When in mac application
  (when (memq window-system '(mac ns))
    (global-unset-key "\C-x\C-c")
    (exec-path-from-shell-initialize)))
;; Then the rest
(use-package ag :ensure t :defer t)

(use-package agda2-mode
  :mode ("\\.agda\\'" . agda2-mode)
  :defer t
  :config
  (defvar agda2-lsb '((t (:foreground "light slate blue"))))
  (custom-set-faces
    '(agda2-highlight-datatype-face agda2-lsb)
    '(agda2-highlight-function-face agda2-lsb)
    '(agda2-highlight-postulate-face agda2-lsb)
    '(agda2-highlight-primitive-face  agda2-lsb)
    '(agda2-highlight-primitive-type-face agda2-lsb)
    '(agda2-highlight-record-face agda2-lsb)))

(use-package auctex :ensure t :defer t)

(use-package clojure-mode
  :defer t
  :config
  (use-package smartparens-config)
  (use-package cider :defer t)
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode))

(use-package coffee-mode
  :defer t
  :config (setq coffee-tab-width 2))

(use-package company
  :ensure t
  :defer t
  :init
  (setq company-idle-delay 0.2)
  (add-hook 'after-init-hook #'global-company-mode))

(use-package csv-mode :ensure t :defer t)

(use-package dockerfile-mode :ensure t :defer t)

(use-package easy-kill :ensure t :defer t)

(use-package erlang :defer t)
(use-package esup :ensure t)

(use-package exec-path-from-shell :ensure t :defer t)

(use-package flycheck
  :ensure t
  :defer t
  :defer t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package go-mode :defer t)

(use-package guide-key
  :ensure t
  :defer t
  :config
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
  (setq guide-key/idle-delay 1.0)
  (guide-key-mode 1))

(use-package haskell-mode
  :ensure t
  :bind (("C-," . haskell-move-nested-left)
	 ("C-." . haskell-move-nested-right))
  :init
  (bind-key "C-<" '(kbd "C-u C-,"))
  (bind-key "C->" '(kbd "C-u C-."))
  :config
  (add-hook 'haskell-mode-hook 'haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  (custom-set-variables
    '(haskell-process-suggest-remove-import-lines t)
    '(haskell-process-auto-import-loaded-modules t)
    '(haskell-process-log t)
    '(haskell-process-type (quote stack-ghci))
    '(haskell-process-path-ghci "stack")
    '(haskell-process-args-ghci "ghci"))

  (when (memq window-system '(mac ns x))
    (defvar haskell-ligature-list
      '(("->" . "")
	("<-" . "")
	("=>" . "")
	("!!" . "")
	("&&" . "")
	("||" . "")
	("-<" . "")
	(">-" . "")
	("::" . "")
	("++" . "")
	("+++" . "")
	(".." . "")
	("..." . "")
	("<$>" . "")
	("<>" . "")
	("<*" . "")
	("*>" . "")
	("***" . "")
	("<*>" . "")
	("<|" . "")
	("<|>" . "")
	("<+>" . "")
	(">>" . "")
	("<<" . "")
	("<<<" . "")
	(">>>" . "")
	(">>=" . "")
	("=<<" . "")))
    (setq haskell-font-lock-symbols-alist
      (append haskell-ligature-list haskell-font-lock-symbols-alist)))
  (setq haskell-font-lock-symbols t)
  (use-package company-ghci
    :ensure t
    :after company
    :config
    (push 'company-ghci company-backends))
  (use-package ghc :ensure t))

(use-package helm
  :ensure t
  :defer t
  :config (use-package helm-config))

(use-package imenu-anywhere
  :ensure t
  :bind ("C-c i" . imenu-anywhere))

(use-package idris-mode :defer t)

(use-package js2-mode
  :defer t
  :ensure t
  :config
  (add-hook 'js2-mode-hook
   (lambda () (push '("function" . ?λ) prettify-symbols-alist))))

(use-package json-mode
  :ensure t
  :defer
  :bind ("C-c C-f" . json-reformat-region)
  :config
  (setq json-reformat:indent-width 2))

(use-package magit :ensure t :defer t)

(use-package markdown-mode :ensure t :defer t)

(use-package multiple-cursors
  :ensure t
  :defer t
  :config (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines))

(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle))

(use-package nix-mode :ensure t :defer t)

(use-package protobuf-mode :defer t)

(use-package puppet-mode :defer t)

(use-package purescript-mode
  :after flycheck
  :bind (("C-," . purescript-move-nested-left)
	 ("C-." . purescript-move-nested-right))
  :init
  (bind-key "C-<" '(kbd "C-u C-,"))
  (bind-key "C->" '(kbd "C-u C-."))
  :config
  (add-hook 'purescript-mode-hook #'turn-on-purescript-indentation))

(use-package python-mode
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :after company
  :config
  (add-hook 'python-mode-hook
    (lambda ()
      (exec-path-from-shell-copy-env "CONDA_ENV_PATH")
      (company-mode -1)))
  (use-package virtualenv :ensure t)
  (use-package jedi
    :ensure t
    :config
    (add-hook 'python-mode-hook 'jedi:setup)
    (setq jedi:complete-on-dot t)
    (setq jedi:get-in-function-call-delay 500)))

(use-package rainbow-delimiters :ensure t)

(use-package rainbow-mode :ensure t)

(use-package rust-mode :defer t)

(use-package sh-script
  :defer t
  :mode ("\\.zsh\\'" . sh-mode)
  :config (setq sh-indentation 2 sh-basic-offset 2))

(use-package smartparens :ensure t :defer t)

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

(use-package todotxt :mode ("\\todo.txt\\'" . todotxt-mode))

(use-package tuareg :defer t)

(use-package twittering-mode :ensure t :defer t)

(use-package yaml-mode :ensure t :defer t)

(use-package yasnippet :disabled t :ensure t :defer t)

(provide '.emacs)
;;; .emacs ends here
