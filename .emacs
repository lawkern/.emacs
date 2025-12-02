(global-set-key (kbd "C-;") 'execute-extended-command)
(global-set-key (kbd "C-'") 'recompile)
(global-set-key (kbd "C-M-'") 'compile)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "C-c b") 'revert-buffer)
(global-set-key (kbd "C-c f") 'ff-find-other-file)
(global-set-key (kbd "C-c c") 'quick-calc)

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (previous-line 2))

(defun move-line-down ()
  (interactive)
  (next-line 1)
  (transpose-lines 1)
  (previous-line 1))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(global-set-key (kbd "<f2>") 'rgrep)
(global-set-key (kbd "<f5>") 'recompile)

(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-h h") nil)
;; (global-set-key (kbd "C-x C-c") nil)

(setq next-line-add-newlines nil)
(setq use-short-answers t)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq compilation-ask-about-save nil)

(setq-default make-backup-files nil)
(setq-default create-lockfiles nil)

(menu-bar-mode 0)
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (fringe-mode '(1 . 1)))

(column-number-mode 1)

(setq-default fill-column 80)
(setq-default truncate-lines 0)

;; NOTE: Don't let Emacs create splits when new windows are created
;; e.g. *compilation*. Try to reuse manually created splits, or else stick to
;; one window.
(setq display-buffer-base-action
      '((display-buffer-reuse-window
         display-buffer-reuse-mode-window
         display-buffer-use-some-window)))

(setq-default tab-width 3)
(setq-default indent-tabs-mode nil)

(setq-default c-default-style "linux")
(setq-default c-basic-offset 3)

;; NOTE: It's annoying that Emacs can't find a project's Makefile by default if
;; you're working in a subdirectory.
(defun compile-with-closest-makefile ()
  (let ((path-to-makefile (locate-dominating-file default-directory "Makefile")))
    (if path-to-makefile
        (format "make -C %s " path-to-makefile)
      "make ")))
(setq-default compile-command '(compile-with-closest-makefile))

(require 'grep)
(grep-apply-setting 'grep-command "grep -nRHe ")

(defun configure-c-mode ()
  (local-set-key (kbd "C-'") 'recompile)
  (setq indent-tabs-mode nil)
  (c-toggle-comment-style -1)
  (c-set-offset 'case-label '+)
  (c-set-offset 'statement-cont 0)

  (setq-local whitespace-style '(face tabs tab-mark))
  (whitespace-mode 1)

  (font-lock-add-keywords
   nil
   '(("\\<\\(0[xX][0-9A-Fa-f]+\\|0[bB][01]+\\|0[0-7]+\\|[0-9]+\\)\\(?:\\.[0-9]+\\)?\\(?:[eE][+-]?[0-9]+\\)?\\(?:[uUlLfF]+\\)?\\>"
      0 font-lock-string-face)))
  )

(add-hook 'c-mode-common-hook 'configure-c-mode)

(defun configure-org-mode ()
  ;; NOTE: Org-mode has some nerve with the keybindings it tries to steal.
  (define-key org-mode-map (kbd "C-'") nil))

(add-hook 'org-mode-hook 'configure-org-mode)

(setq-default js-indent-level 3)
(setq-default js-switch-indent-offset 3)
(setq-default css-indent-offset 3)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq show-paren-delay 0)
(show-paren-mode 1)

(setq-default isearch-allow-motion t)

;; (add-to-list 'default-frame-alist '(font . "Iosevka Law-10"))
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-9"))

;; (set-face-font 'fixed-pitch "Iosevka Law")
(set-face-font 'fixed-pitch "JetBrains Mono")

(setq modus-themes-common-palette-overrides '((preprocessor fg-main)))
(load-theme 'modus-vivendi t nil)
;; (set-face-attribute 'region nil :background 'unspecified :foreground 'unspecified :inherit nil)

(modus-themes-with-colors
 (defface font-lock-comment-note
   `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,blue-cooler)))
   "NOTE comment highlighting")

 (defface font-lock-comment-todo
   `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,red-cooler)))
   "TODO comment highlighting")

 (defface font-lock-comment-important
   `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,yellow-warmer)))
   "IMPORTANT comment highlighting")

 (defface font-lock-comment-nocheckin
   `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,magenta-intense)))
   "NOCHECKIN comment highlighting")

 (defface font-lock-comment-bug
   `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,green-intense)))
   "BUG comment highlighting")
 )

(defun highlight-comment-keywords ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(NOTE\\)\\>\\(:\\|(\\)"      1 'font-lock-comment-note prepend)      ; NOTE: Test comment.
     ("\\<\\(TODO\\)\\>\\(:\\|(\\)"      1 'font-lock-comment-todo prepend)      ; TODO: Test Comment.
     ("\\<\\(IMPORTANT\\)\\>\\(:\\|(\\)" 1 'font-lock-comment-important prepend) ; IMPORTANT: Test Comment.
     ("\\<\\(NOCHECKIN\\)\\>\\(:\\|(\\)" 1 'font-lock-comment-nocheckin prepend) ; NOCHECKIN: Test Comment.
     ("\\<\\(BUG\\)\\>\\(:\\|(\\)"       1 'font-lock-comment-bug prepend))))    ; BUG: Test Comment.

(add-hook 'prog-mode-hook 'highlight-comment-keywords)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; OS-dependent:
(when (eq system-type 'windows-nt)
  (setq grep-use-null-device t)
  (setq grep-command "findstr -snil "))

(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

  (setq ns-use-proxy-icon nil)
  (setq frame-title-format nil)
  (setq mac-option-modifier 'super)
  (setq mac-command-modifier 'meta))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-maximum-decoration '((t . 1)))
 '(package-selected-packages '(magit nasm-mode rg)))

(put 'upcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:background "yellow" :foreground "red")))))
