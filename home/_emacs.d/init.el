;;;
;;; Custom:
;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flutter-l10n-flycheck flutter dart-mode elpy doom-themes zenburn-theme lsp-ui company-lsp lsp-mode treemacs-magit treemacs-icons-dired treemacs-projectile treemacs hl-todo editorconfig nyan-mode company-nginx nginx-mode docker-compose-mode company-go go-mode company-jedi restclient js2-mode tide web-mode yaml-mode markdown-mode yasnippet-snippets yasnippet company flycheck projectile docker magit counsel ivy ace-window org-bullets iedit which-key exec-path-from-shell dockerfile-mode company-restclient use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;
;;; Misc Emacs tweaks
;;;

;;; UI tweaks
(load-theme 'deeper-blue)
(column-number-mode t)
(global-linum-mode 1)
(show-paren-mode t)
(tool-bar-mode 0)
(global-hl-line-mode t)
(setq inhibit-startup-screen t)

;;; a tab is 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;;; backup file tweaks
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;;; Font tweaks
;; ubuntu linux
(when (memq window-system '(x))
  (set-frame-font "Ubuntu Mono 12" nil t))
;; macos
(when (memq window-system '(mac ns))
  (set-frame-font "Menlo 12" nil t))

;;; flyspell (hunspell)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;;; binding tweaks
(global-set-key [f5] 'revert-buffer)
;;(global-set-key [f6] 'goto-line)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key [f7] 'compile)
(global-set-key [f8] 'company-complete)

;;;
;;; MELPA
;;;

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
 	     '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)

;;;
;;; Use Package
;;;

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;;
;;; Misc Emacs Packages
;;;

;;;; exec-path-from-shell
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;;;; which-key
(use-package which-key
  :config
  (which-key-setup-side-window-right-bottom) ; either this
  ;; (which-key-setup-minibuffer)            ; or this
  (which-key-mode))

;;;; iedit
(use-package iedit)

;;;; ace-windows
(use-package ace-window
  :bind ("M-o" . ace-window))

;;;; ivy, counsel, swiper
(use-package ivy)
(use-package counsel)
(use-package swiper)
;; their configs
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-display-style 'fancy)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
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
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;;
;;; ORG MODE
;;;

;;;; org-bullets
(use-package org-bullets
  :config (add-hook 'org-mode-hook 'org-bullets-mode))

(setq org-log-done 'time)

;;;; agenda

;;;; capture

;;;; babel

;;;
;;; Utilities
;;;

;;;; magit
(use-package magit
  :bind ("C-x g" . magit-status))

;;;; docker
(use-package docker
  :bind ("C-c d" . docker))

;;;
;;; Code Editor
;;;

;;;; projectile
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))
(setq projectile-project-search-path '("~/github/")) ; put all your project directories here

;;;; search
(use-package ag)
(use-package deadgrep)
(use-package wgrep)

;;;; flycheck
(use-package flycheck
  :config (global-flycheck-mode))

;;;; company
(use-package company
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (add-hook 'after-init-hook 'global-company-mode))

;;;; yasnippet
(use-package yasnippet
  :config (yas-global-mode 1))
(use-package yasnippet-snippets)

;;;; editorconfig
;;(use-package editorconfig
;;  :config (editorconfig-mode 1))

;;;; hl-todo
(use-package hl-todo
  :config (global-hl-todo-mode))

;;;; treemacs
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

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; company-lsp integrates company mode completion with lsp-mode.
;; completion-at-point also works out of the box but doesn't support snippets.
(use-package company-lsp
  :commands company-lsp)

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;;; Code Modes:

(use-package markdown-mode
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'" . markdown-mode)
   ("\\.markdown\\'" . markdown-mode))
  :init                               ; must install locally
  (setq markdown-command "markdown")  ; markdown or grip
  (setq markdown-split-window-direction 'right))

(use-package json-mode)
(use-package yaml-mode)

;;;; front-end
(use-package web-mode)
(use-package js2-mode)
(use-package typescript-mode)
(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

;;;; restclient
(use-package restclient)
(use-package company-restclient)

;;;; python
(use-package elpy
  :init (elpy-enable))

;;;; flutter / dart
(use-package dart-mode)

(use-package flutter
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload)))

(use-package flutter-l10n-flycheck
  :after flutter
  :config
  (flutter-l10n-flycheck-setup))

;;;; golang
(use-package go-mode)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;;;; docker
(use-package dockerfile-mode)
(use-package docker-compose-mode)

;;;; nginx
(use-package nginx-mode)
(use-package company-nginx)

;;;
;;; Fun:
;;;

;;;; nyan-mode
(use-package nyan-mode)
