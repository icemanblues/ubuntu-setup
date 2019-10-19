(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(package-selected-packages
   (quote
    (web-mode company-jedi lsp-javascript-typescript lsp-python-ms lsp-java lsp-python lsp-mode multi-term magit dockerfile-mode restclient nginx-mode markdown-mode golint go-guru go-dlv go-imports go-tag go-complete go-autocomplete company-go go-mode)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; MELPA
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; additional keybings
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key [f5] 'compile)
(global-set-key [f6] 'goto-line)

;; my recommendations
(global-linum-mode 1)

;; recommended from john
;(tool-bar-mode 0)
;(menu-bar-mode 0)
;(scroll-bar-mode 0)
