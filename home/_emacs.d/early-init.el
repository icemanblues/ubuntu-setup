;; -*- lexical-binding: t; -*-
;; early-init.el --- loaded before package.el and the GUI are initialized

;;; Commentary:

;; Install location: this file must physically live in the real
;; `user-emacs-directory' (XDG convention: ~/.config/emacs/early-init.el; legacy
;; ~/.emacs.d/early-init.el still works).  Unlike init.el it CANNOT be sourced
;; via (load-file ...) — Emacs reads early-init.el directly, before init runs.
;;
;; Emacs 27+ loads this file before `package-initialize' and before the frame
;; is created.  Startup-performance tweaks (GC tuning, file-name-handler-alist)
;; belong here rather than in init.el so they take effect as early as possible.

;;; Code:

;;;
;;; Garbage Collection
;;;

;; No GC during startup: crank the threshold way up, then restore a sane value
;; once Emacs has finished loading.
(defvar doom-gc-cons-threshold 16777216 ; 16mb
  "The GC threshold to restore to after startup / minibuffer use.")

(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold doom-gc-cons-threshold
          gc-cons-percentage 0.1)))

;; No GC while the minibuffer is active.
(defun doom-defer-garbage-collection-h ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun doom-restore-garbage-collection-h ()
  ;; Defer it so that commands launched immediately after will enjoy the
  ;; benefits.
  (run-at-time
   1 nil (lambda () (setq gc-cons-threshold doom-gc-cons-threshold))))

(add-hook 'minibuffer-setup-hook #'doom-defer-garbage-collection-h)
(add-hook 'minibuffer-exit-hook #'doom-restore-garbage-collection-h)

;; TODO: consider replacing the manual GC juggling above with the `gcmh'
;; package, which handles this more robustly.

;;;
;;; file-name-handler-alist
;;;

;; Unset file-name-handler-alist temporarily to avoid regex lookups on every
;; file loaded during startup; restore it afterwards.
(defvar doom--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq file-name-handler-alist doom--file-name-handler-alist)))

;;; early-init.el ends here
