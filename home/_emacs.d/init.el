;;;
;;; Custom:
;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (dockerfile-mode company-restclient use-package))))
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

;;; backup file tweaks
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;;; Font tweaks
;; ubuntu linux
(when (memq window-system '(x))
  (set-frame-font "Ubuntu Mono 16" nil t))
;; macos
(when (memq window-system '(mac ns))
  (set-frame-font "Menlo 16" nil t))

;;; binding tweaks
(global-set-key [f5] 'revert-buffer)
(global-set-key [f6] 'goto-line)
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

;;;; org-bullets
(use-package org-bullets
  :config (add-hook 'org-mode-hook 'org-bullets-mode))

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
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

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

;;;; flycheck
(use-package flycheck
  :config (global-flycheck-mode))

;;;; company
(use-package company
  :config (add-hook 'after-init-hook 'global-company-mode))

;;;; yasnippet
(use-package yasnippet
  :config (yas-global-mode 1))
(use-package yasnippet-snippets)

;;; Code Modes:

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)) ; must install locally
  :init (setq markdown-command "grip"))      ; markdown or grip

(use-package json-mode)
(use-package yaml-mode)

;;;; front-end
(use-package web-mode)
(use-package tide)
(use-package js2-mode)
;;(use-package web-beautify)

;;;; restclient
(use-package restclient)
(use-package company-restclient)

;;;; python
(use-package company-jedi)

;;;; golang
(use-package go-mode)
(use-package company-go)
;; (add-hook 'go-mode-hook 'lsp-deferred) ;; lsp-mode ;; from go-mode

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

;;;
;;; LSP MODE
;;;

;;;; lsp-mode
;;(use-package lsp-mode
;;  :hook (XXX-mode . lsp)
;;  :commands lsp)

;;;; lsp-ui
;;(use-package lsp-ui :commands lsp-ui-mode)
;;;; company-lsp
;;(use-package company-lsp :commands company-lsp)
;;;; dap-mode
;;(use-package dap-mode)
