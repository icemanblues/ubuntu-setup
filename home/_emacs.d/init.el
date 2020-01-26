;; icemanblues' emacs configurations
;; add this file to your local ~/emacs.d/init.el
;; (load-file "path/to/this/init.el")

;;;
;;; MELPA
;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(setq package-enable-at-startup nil)
(package-initialize)

;;;
;;; USE PACKAGE
;;;

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package diminish)
(use-package delight)

;;;
;;; EMACS TWEAKS
;;;

;; UI tweaks
(column-number-mode t)
(global-linum-mode 1)
(show-paren-mode t)
(tool-bar-mode 0)
(global-hl-line-mode t)
(setq inhibit-startup-screen t)

;; a tab is 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; backup file tweaks
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; Font tweaks
;; ubuntu linux
(when (memq window-system '(x))
  (set-frame-font "Ubuntu Mono 12" nil t))
;; macos
(when (memq window-system '(mac ns))
  (set-frame-font "Menlo 12" nil t))

;; binding tweaks
(global-set-key [f5] 'revert-buffer)
(global-set-key [f6] 'ivy-resume)
(global-set-key [f7] 'compile)
(global-set-key [f8] 'goto-line)

;;;
;;; Themes
;;;

(use-package zenburn-theme)
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (doom-themes-visual-bell-config))

;;(load-theme 'doom-wilmersdorf)
;;(load-theme 'doom-outrun-electric)
;;(load-theme 'doom-one)
;;(load-theme 'doom-dracula)
;;(load-theme 'doom-vibrant)
;;(load-theme 'deeper-blue)
;;(load-theme 'zenburn)

;; doom-moodline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;;;
;;; MISCELLANEOUS
;;;

;; exec-path-from-shell
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; which-key
(use-package which-key
  :diminish
  :config
  (which-key-setup-side-window-right-bottom) ; either this
  ;; (which-key-setup-minibuffer)            ; or this
  (which-key-mode))

;; flyspell (hunspell)
(use-package flyspell
  :diminish
  :hook
  ((text-mode . flyspell-mode)
   (prog-mode . flyspell-prog-mode)))

;; eldoc
(use-package eldoc :diminish)

;; iedit
(use-package iedit)

;; goto last change
(use-package goto-chg
  :bind
  (("C-c C-q" . goto-last-change)
   ("C-c C-w" . goto-last-change-reverse)))

;; ace-windows
(use-package ace-window
  :bind ("M-o" . ace-window))

;; ivy, counsel, swiper
(use-package ivy :diminish
  :config (ivy-mode 1))
(use-package counsel :diminish
  :config (counsel-mode 1))
(use-package swiper)

(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-display-style 'fancy)
(setq search-default-mode #'char-fold-to-regexp) ; enable this if you want `swiper' to use it
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;;
;;; ORG MODE
;;;

(setq org-log-done 'time)

;; org-bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; agenda
;; capture
;; babel

;;;
;;; UTILITIES
;;;

;; magit
(use-package magit
  :bind ("C-x g" . magit-status))

;; docker
(use-package docker
  :bind ("C-c d" . docker))

;; pdf tools
(use-package pdf-tools
  :config (pdf-tools-install))

;; kubernetes
(use-package kubernetes
  :commands (kubernetes-overview))

;;;
;;; CODE EDITOR (IDE)
;;;

;; projectile
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-search-path '("~/github/")) ; put all your project directories here
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode +1))

;; search
(use-package ag)
(use-package ripgrep)
(use-package deadgrep)
(use-package wgrep)

;; rainbow
(use-package rainbow-mode
  :diminish
  :hook (prog-mode . rainbow-mode))

;; rainbow delimiters
(use-package rainbow-delimiters
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

;; flymake
(use-package flymake :diminish)

;; flycheck
(use-package flycheck
  :diminish
  :config (global-flycheck-mode))

;; company
(use-package company
  :diminish
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (add-hook 'after-init-hook 'global-company-mode))

;; yasnippet
(use-package yasnippet
  :diminish yas-minor-mode
  :config (yas-global-mode 1))
(use-package yasnippet-snippets)

;; editorconfig
(use-package editorconfig
  :diminish
  :config (editorconfig-mode 1))

;; hl-todo
(use-package hl-todo
  :config (global-hl-todo-mode))

;; centaur tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-group-by-projectile-project)
  :bind
  ("C-S-<tab>" . centaur-tabs-backward)
  ("C-<tab>" . centaur-tabs-forward)
  ("C-c t s" . centaur-tabs-counsel-switch-group)
  ("C-c t p" . centaur-tabs-group-by-projectile-project)
  ("C-c t g" . centaur-tabs-group-buffer-groups))

;; treemacs
(use-package treemacs
  :config
  ;;(treemacs-resize-icons 44) ; uncomment on Hi-DPI display
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t)
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))
(use-package treemacs-projectile
  :after treemacs projectile)
(use-package treemacs-icons-dired
  :after treemacs dired
  :config (treemacs-icons-dired-mode))
(use-package treemacs-magit
  :after treemacs magit)

;;;
;;; LSP MODE
;;;

;; language server protocol
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  ((python-mode . lsp-deferred)
   ;;(java-mode . lsp-deferred)
   (dart-mode . lsp-deferred)
   (js-mode . lsp-deferred)
   (js2-mode . lsp-deferred)
   (rjsx-mode . lsp-deferred)
   (typescript-mode . lsp-deferred)
   (go-mode . lsp-deferred)))

(use-package company-lsp :commands company-lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; debugger (dap)
(use-package dap-mode
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1))

;;;
;;; CODE MODE
;;;

(use-package markdown-mode
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'" . markdown-mode)
   ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "markdown") ; must install locally markdown or grip
  (setq markdown-split-window-direction 'right))

(use-package json-mode)
(use-package yaml-mode)
(use-package protobuf-mode)

;; front-end
(use-package web-mode
  :mode ("\\.html?\\'" . web-mode))
(use-package js2-mode
  :mode ("\\.js\\'" . js2-mode))
(use-package rjsx-mode)
(use-package typescript-mode)
(use-package emmet-mode
  :hook
  ((sgml-mode . emmet-mode)
   (web-mode . emmet-mode)
   (css-mode . emmet-mode))
  :config
  (setq emmet-move-cursor-between-quotes t)
  (setq emmet-expand-jsx-className? t)
  (setq emmet-self-closing-tag-style " /"))

;; restclient
(use-package restclient)
(use-package company-restclient)

;; python
(use-package python-mode
  :config
  (setq python-indent-offset 4)
  (setq python-shell-interpreter "python3"))

(use-package pyvenv)

;; flutter / dart
(use-package dart-mode)

(use-package flutter
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload)))

(use-package flutter-l10n-flycheck
  :after flutter
  :config
  (flutter-l10n-flycheck-setup))

;; java
;;(use-package lsp-java :after lsp :disabled)

;; golang
(use-package go-mode)
;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; docker
(use-package dockerfile-mode)
(use-package docker-compose-mode)

;; nginx
(use-package nginx-mode)
(use-package company-nginx)

;;;
;;; Fun:
;;;

;; nyan-mode
(use-package nyan-mode)
