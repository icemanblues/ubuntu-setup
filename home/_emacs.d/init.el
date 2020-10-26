;; init.el --- icemanblues's emacs configurations         -*- lexical-binding: t; -*-

;;; Commentary:

;; add this line to your top of your local ~/emacs.d/init.el
;; (load-file "path/to/this/init.el")

;; On your first load, you'll need to run this manually once
;; M-x all-the-icons-install-fonts

;; add one of the below to add the theme to your ~/emacs.d/init.el
;; (load-theme 'doom-outrun-electric t)
;; (load-theme 'doom-laserwave t)
;; (load-theme 'doom-one t)
;; (load-theme 'doom-acario-dark t)
;; (load-theme 'doom-vibrant t)
;; (load-theme 'doom-wilmersdorf t)
;; (load-theme 'zenburn t)
;; (load-theme 'deeper-blue t)


;;; Code:

;;;
;;; Garbage Collection
;;;

;; no gc during startup

(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      doom-gc-cons-threshold 16777216 ; 16mb
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold doom-gc-cons-threshold
          gc-cons-percentage 0.1)))

;; no gc during minibuffer use
(defun doom-defer-garbage-collection-h ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun doom-restore-garbage-collection-h ()
  ;; Defer it so that commands launched immediately after will enjoy the
  ;; benefits.
  (run-at-time
   1 nil (lambda () (setq gc-cons-threshold doom-gc-cons-threshold))))

(add-hook 'minibuffer-setup-hook #'doom-defer-garbage-collection-h)
(add-hook 'minibuffer-exit-hook #'doom-restore-garbage-collection-h)

;; Unset file-name-handler-alist temporarily

(defvar doom--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
  (lambda ()
    (setq file-name-handler-alist doom--file-name-handler-alist)))

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
  (set-frame-font "Menlo 14" nil t))

;; binding tweaks
(global-set-key [f5] 'revert-buffer)
(global-set-key [f6] 'ivy-resume)
(global-set-key [f7] 'compile)
(global-set-key [f8] 'goto-line)

;;;
;;; Themes
;;;

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (doom-themes-visual-bell-config))

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

;; golden-ratio
(use-package golden-ratio
  :config (golden-ratio-mode 1))

;; all the icons
(use-package all-the-icons)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
(use-package all-the-icons-ivy
  :after ivy
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

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

;; posframe
(use-package posframe)

(use-package which-key-posframe
  :config (which-key-posframe-mode))

(use-package flycheck-posframe
  :after flycheck
  :config (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode))

(use-package ivy-posframe
  :init
  ;; display at `ivy-posframe-style'
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
  :config (ivy-posframe-mode 1))

;;;
;;; ORG MODE
;;;

;; org-bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; log time of time when done
(setq org-log-done 'time)

;; org-capture
(global-set-key (kbd "C-c c") 'org-capture)

;; (setq org-capture-templates
;; '(("a" "Appointment" entry (file  "~/Dropbox/orgfiles/gcal.org" "Appointments")
;;    "* TODO %?\n:PROPERTIES:\n\n:END:\nDEADLINE: %^T \n %i\n")
;; ("n" "Note" entry (file+headline "~/Dropbox/orgfiles/notes.org" "Notes")
;;  "* Note %?\n%T")
;; ("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
;;  "* %? %^L %^g \n%T" :prepend t)
;; ("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
;;  "* %?\n%T" :prepend t)
;; ("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do Items")
;;  "* %?\n%T" :prepend t)
;; ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
;;  "* %?\nEntered on %U\n  %i\n  %a")
;; ("s" "Screencast" entry (file "~/Dropbox/orgfiles/screencastnotes.org")
;;  "* %?\n%i\n")))

;; agenda
;; (setq org-agenda-files (list "~/Dropbox/orgfiles/gcal.org"
;;                              "~/Dropbox/orgfiles/i.org"
;;                              "~/Dropbox/orgfiles/schedule.org"))

;; (setq org-agenda-custom-commands
;;       '(("c" "Simple agenda view"
;;          ((agenda "")
;;           (alltodo "")))))

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

;; stackoverflow
(use-package sx
  :config
  (bind-keys :prefix "C-c s"
             :prefix-map my-sx-map
             :prefix-docstring "Global keymap for SX."
             ("q" . sx-tab-all-questions)
             ("i" . sx-inbox)
             ("o" . sx-open-link)
             ("u" . sx-tab-unanswered-my-tags)
             ("a" . sx-ask)
             ("s" . sx-search)))

;;;
;;; CODE EDITOR (IDE)
;;;

;; projectile
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  ;; put all your project directories here
  (setq projectile-project-search-path '("~/code/"))
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

;; highlight-parentheses
(use-package highlight-parentheses
  :config (highlight-parentheses-mode 1))

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
  :init
  (setq centaur-tabs-set-icons t)
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
  :after golden-ratio
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
(use-package treemacs-magit
  :after treemacs magit)

;;;
;;; LSP MODE
;;;

;; language server protocol
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "s-l")
  :config
  (lsp-modeline-diagnostics-mode)
  (lsp-modeline-code-actions-mode)
  (lsp-modeline-workspace-status-mode)
  (lsp-headerline-breadcrumb-mode)
  :commands
  (lsp lsp-deferred)
  :hook
  ((python-mode . lsp-deferred)
   (dart-mode . lsp-deferred)
   (js-mode . lsp-deferred)
   (js2-mode . lsp-deferred)
   (rjsx-mode . lsp-deferred)
   (typescript-mode . lsp-deferred)
   (go-mode . lsp-deferred)))

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

;; debugger (dap)
(use-package dap-mode
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1)
  :hook
  dap-stopped-hook . (lambda (arg) (call-interactively #'dap-hydra)))

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
(setq python-indent-offset 4)
(setq python-shell-interpreter "python3")

(use-package lsp-pyright
  :hook
  (python-mode . (lambda ()
                   (require 'lsp-pyright)
                   (lsp-deferred))))

(require 'dap-python)

(use-package pyvenv)
(use-package ein)

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
;;(use-package lsp-java :after lsp)

;; golang

(use-package go-mode
  ;; Set up before-save hooks to format buffer and add/delete imports.
  ;; Make sure you don't have other gofmt/goimports hooks enabled.
  :hook
  (go-mode . (lambda ()
               (add-hook 'before-save-hook #'lsp-format-buffer t t)
               (add-hook 'before-save-hook #'lsp-organize-imports t t))))


;; docker
(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package lsp-docker)

;; nginx
(use-package nginx-mode)
(use-package company-nginx)

;;;
;;; Fun:
;;;

;; nyan-mode
(use-package nyan-mode)
