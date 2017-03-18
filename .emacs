;; Package --- Summary
;;; Commentary:
;;; Code:
(defvar *emacs-load-start* (current-time))
(defvar dotfiles-dir)
(setq dotfiles-dir
  (file-name-directory (or load-file-name (buffer-file-name))))
(prefer-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

;; Bootstrap
(setq package-enable-at-startup nil)
(setq vc-follow-symlinks t)
(setq-default yank-excluded-properties 't)
(setq column-number-mode t)
(setq inhibit-startup-screen t)
(setq ring-bell-function #'ignore)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(when (memq window-system '(ns mac))
  (setq-default mac-option-key-is-meta t)
  (setq-default mac-right-option-modifier nil)
  (setq ns-use-srgb-colorspace nil)
  (set-frame-font "PragmataPro" t t)
  (tool-bar-mode 1)
  (scroll-bar-mode 0)
  (global-unset-key "\C-x\C-c"))

;; Display crap
;(set-frame-parameter (selected-frame) 'alpha '(85 70))

(global-prettify-symbols-mode +1)

(require 'package)
(setq package-archives
  '(("gnu" . "http://elpa.gnu.org/packages/")
    ("org" . "http://orgmode.org/elpa/")
    ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
    ("melpa" . "http://melpa.milkbox.net/packages/")
    ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; My stuff first
(use-package misc
  :defer t
  :load-path "site-lisp"
  :bind (("s-<insert>" . paste-primary-selection)
	 ([f1] . eshell)))

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

(use-package ansible :defer t :ensure t)

(use-package auctex :ensure t :defer t)

(use-package clojure-mode
  :defer t
  :ensure t
  :mode "\\.clj$"
  :config
  (use-package smartparens :defer t :ensure t)
  (use-package cider :defer t :ensure t)
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook
    #'(lambda () (when (eq window-system 'ns)
	      (exec-path-from-shell-initialize)))))

(use-package coffee-mode
  :defer t
  :config (setq coffee-tab-width 2))

(use-package company
  :ensure t
  :defer t
  :init
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 1)
  (add-hook 'after-init-hook #'global-company-mode))

(use-package csv-mode :ensure t :defer t)

(use-package darcula-theme
  :ensure t
  :defer f
  :init (require 'darcula-theme))

(use-package dockerfile-mode :ensure t :defer t)

(use-package easy-kill :ensure t :defer t)

(use-package erlang :defer t)

(use-package eshell
  :defer t
  :init
  (add-hook 'eshell-mode-hook
   #'(lambda () (company-mode -1)
	   (when (eq window-system 'ns)
	     (exec-path-from-shell-initialize)))))

(use-package esup :ensure t :defer t)

(use-package exec-path-from-shell
  :defer t
  :init
  (setq exec-path-from-shell-arguments '("-l")))
(use-package flycheck
  :ensure t
  :defer t
  :init
  (setq flycheck-idle-change-delay 0.1)
  (setq flycheck-display-errors-delay 0.3)
  (setq-default flycheck-disabled-checkers
   (append flycheck-disabled-checkers
    '(javascript-jshint)))
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package geiser :defer t)

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
	 ("C-." . haskell-move-nested-right)
	 ("C-c C-t" . haskell-doc-show-type)
	 ("M-<up>" . haskell-interactive-mode-history-previous)
	 ("M-<down>" . haskell-interactive-mode-history-previous))
  :init
  (bind-key "C-<" '(kbd "C-u C-,"))
  (bind-key "C->" '(kbd "C-u C-."))
  :config
  (add-hook 'haskell-mode-hook
    #'(lambda () (when (eq window-system 'ns)
	      (exec-path-from-shell-initialize))))
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  (custom-set-variables
   '(haskell-process-suggest-remove-import-lines t)
   '(haskell-process-auto-import-loaded-modules t)
   '(haskell-process-log t)
   '(haskell-interactive-popup-errors nil)
   '(haskell-process-type (quote stack-ghci))
   '(haskell-font-lock-symbols t)
   '(haskell-process-path-ghci "stack")
   '(haskell-process-args-ghci "ghci"))

  (when (memq window-system '(mac ns))
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

  (use-package flycheck-haskell
    :ensure t
    ;:after flycheck
    :init (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

  (use-package company-ghci
    :ensure t
    ;:after company
    :init (push 'company-ghci company-backends))
  ;; (use-package intero
  ;;   :ensure t
  ;;   :init (add-hook 'haskell-mode-hook 'intero-mode))
  (use-package ghc :ensure t))

(use-package helm
  :ensure t
  :defer t
  :config (use-package helm-config))

(use-package imenu-anywhere
  :ensure t
  :bind ("C-c i" . imenu-anywhere))

(use-package idris-mode :defer t)

(use-package jinja2-mode :defer t)

(use-package js2-mode
  :defer t
  :ensure t
  :config
  (setq js-indent-level 2)
  (add-hook 'js2-mode-hook
   (lambda () (push '("function" . ?λ) prettify-symbols-alist)))
  (setq-default flycheck-disabled-checkers
   (append flycheck-disabled-checkers
    '(json-jsonlist))))

(use-package json-mode
  :ensure t
  :bind ("C-c C-f" . json-reformat-region)
  :config (setq json-reformat:indent-width 2))

(use-package magit :ensure t :defer t)

(use-package markdown-mode
  :ensure t
  :defer t
  :config
  (use-package flymd
    :load-path "site-lisp/flymd/"
    :config (defun my-flymd-browser-function (url)
	      (let ((process-environment (browse-url-process-environment)))
		(apply 'start-process
		       (concat "firefox " url)
		       nil
		       "/usr/bin/open"
		       (list "-a" "firefox" url))))
    (setq flymd-browser-open-function 'my-flymd-browser-function)))

(use-package multiple-cursors
  :ensure t
  :defer t
  :config (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines))

(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle))

(use-package nix-mode :ensure t :defer t)

(use-package smart-mode-line
  :ensure t
  :config
  (progn
    (use-package smart-mode-line-powerline-theme :ensure t)
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'powerline)
    (sml/setup)))


(use-package protobuf-mode :defer t)

(use-package puppet-mode :defer t)

;; specify path to the 'psc-ide' executable
(use-package psc-ide
  :ensure t
  :defer t
  :config
  (add-hook 'purescript-mode-hook
    (lambda ()
      (psc-ide-mode)
      (company-mode)
      (flycheck-mode)
      (turn-on-purescript-indentation))))

(use-package purescript-mode
  :after flycheck
  :ensure t
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
  :config
  (add-hook 'python-mode-hook
    (lambda ()
      (exec-path-from-shell-copy-env "CONDA_ENV_PATH")
      (company-mode -1)))
  (use-package virtualenv :ensure t :defer t)
  (use-package jedi
    :ensure t
    :defer t
    :init
    (setq jedi:complete-on-dot t)
    (setq jedi:get-in-function-call-delay 500)
    :config
    (add-hook 'python-mode-hook 'jedi:setup)))

(use-package quack :defer t)

(use-package rainbow-delimiters :ensure t :defer t)

(use-package rainbow-mode :ensure t :defer t)

(use-package rust-mode
  :defer t
  :config
  (use-package flycheck-rust
    :ensure t
    :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
  (use-package racer
    :ensure t
    :bind (("M-." . racer-find-definition)
	   ("TAB" . company-indent-or-complete-common))
    :config
      (setq racer-cmd "/usr/local/bin/racer")
      (setq racer-rust-src-path "~/.rust/src/")
      (add-hook 'racer-mode-hook #'company-mode)
      (add-hook 'racer-mode-hook #'eldoc-mode))
  (add-hook 'rust-mode-hook #'racer-mode)
  (setq company-tooltip-align-annotations t))

(use-package sh-script
  :defer t
  :mode ("\\.zsh\\'" . sh-mode)
  :config (setq sh-indentation 2 sh-basic-offset 2))

(use-package slime
  :ensure t
  :defer t
  :config
  (setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

(use-package smartparens :ensure t :defer t)

(use-package scss-mode :ensure t :defer t)

(use-package tabbar :ensure t :defer t)

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

(use-package tuareg
  :defer t
  :bind ("C-c C-z" . merlin-error-prev)
  :mode ("\\.ml[ily]?$" . tuareg-mode)
  :load-path (lambda ()
	       (exec-path-from-shell-initialize)
	       (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
	       (concat opam-share "/emacs/site-lisp"))
  :config
  (use-package merlin :ensure t)
  ;(add-hook 'tuareg-mode-hook 'run-ocaml)
  (setq tuareg-interactive-program "utop")
  (add-to-list 'company-backends 'merlin-company-backend)
  (add-hook 'tuareg-mode-hook 'merlin-mode t))

(use-package twittering-mode :ensure t :defer t)

(use-package web-mode
  :mode ("\\.jsx$" . web-mode)
  :ensure t
  :after flycheck
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(use-package winner :ensure t :defer t)

(use-package yaml-mode :ensure t :defer t)

(use-package yasnippet :disabled t :ensure t :defer t)

(provide '.emacs)
;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode quack geiser psc-ide yaml-mode virtualenv use-package twittering-mode tuareg tabbar smartparens smart-mode-line-powerline-theme slime scss-mode rainbow-mode rainbow-delimiters racer python-mode purescript-mode ocp-indent nix-mode neotree multiple-cursors merlin markdown-mode magit json-mode js2-mode jinja2-mode jedi intero imenu-anywhere helm guide-key ghc flycheck-rust flycheck-haskell exec-path-from-shell esup easy-kill dockerfile-mode darcula-theme csv-mode company-ghci coffee-mode cider auctex ansible ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
