(global-set-key (kbd "C-;") 'execute-extended-command)
(global-set-key (kbd "C-,") 'other-window)
(global-set-key (kbd "C-c b") 'revert-buffer)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "<f2>") 'rgrep)
(global-set-key (kbd "<f5>") 'recompile)

(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-h h") nil)
(global-set-key (kbd "C-x C-c") nil)

(setq next-line-add-newlines t)
(setq use-short-answers t)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(fringe-mode '(1 . 1))

(setq-default truncate-lines 0)

(setq tab-width 4)
(setq indent-tabs-mode nil)

(setq show-paren-delay 0)
(show-paren-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq-default confirm-nonexistent-file-or-buffer nil)
(ido-mode 1)

;; Font display:
(add-to-list 'default-frame-alist '(font . "Iosevka Law-12"))
(set-face-font 'fixed-pitch "Iosevka Law")

(setq dark-mode t)

(setq text-0    (if dark-mode "#faf1d7" "#faf1d7"))
(setq text-1    (if dark-mode "#ebdbb2" "#ebdbb2"))
(setq text-2    (if dark-mode "#b5a48d" "#b5a48d"))
(setq text-3    (if dark-mode "#928374" "#928374"))
(setq surface-0 (if dark-mode "#21201e" "#21201e"))
(setq surface-1 (if dark-mode "#282828" "#282828"))
(setq surface-2 (if dark-mode "#454240" "#454240"))
(setq surface-3 (if dark-mode "#524e4c" "#524e4c"))

(setq c-0 (if dark-mode "#a6f5c3" "#a6f5c3"))
(setq c-1 (if dark-mode "#84e0a6" "#84e0a6"))
(setq g-0 (if dark-mode "#c3f0b4" "#c3f0b4"))
(setq g-1 (if dark-mode "#92bd79" "#92bd79"))
(setq y-0 (if dark-mode "#ffd77a" "#ffd77a"))
(setq y-1 (if dark-mode "#fabd2f" "#fabd2f"))
(setq y-2 (if dark-mode "#e68c51" "#e68c51"))
(setq r-0 (if dark-mode "#fc8a7b" "#fc8a7b"))
(setq r-1 (if dark-mode "#e36959" "#e36959"))
(setq m-0 (if dark-mode "#f0a5c6" "#f0a5c6"))

(set-face-attribute 'default nil :foreground text-1 :background surface-1)
(set-face-attribute 'fixed-pitch nil :inherit 'default)

(set-face-attribute 'error   nil :foreground r-0)
(set-face-attribute 'fringe  nil :background surface-1)
(set-face-attribute 'link    nil :foreground c-0 :underline t)
(set-face-attribute 'region  nil :background surface-3)
(set-face-attribute 'shadow  nil :foreground surface-2)
(set-face-attribute 'warning nil :foreground y-2)

(set-face-attribute 'font-lock-builtin-face           nil :foreground y-2)
(set-face-attribute 'font-lock-comment-delimiter-face nil :foreground text-3 :slant 'italic)
(set-face-attribute 'font-lock-comment-face           nil :foreground text-3 :slant 'italic)
(set-face-attribute 'font-lock-constant-face          nil :foreground text-1)
(set-face-attribute 'font-lock-doc-face               nil :foreground g-0)
(set-face-attribute 'font-lock-function-call-face     nil :foreground y-1)
(set-face-attribute 'font-lock-function-name-face     nil :foreground y-1)
(set-face-attribute 'font-lock-keyword-face           nil :foreground y-1)
(set-face-attribute 'font-lock-negation-char-face     nil :foreground y-2)
(set-face-attribute 'font-lock-preprocessor-face      nil :foreground text-1)
(set-face-attribute 'font-lock-string-face            nil :foreground g-1)
(set-face-attribute 'font-lock-type-face              nil :foreground y-2)
(set-face-attribute 'font-lock-variable-name-face     nil :foreground text-1)
(set-face-attribute 'font-lock-warning-face           nil :foreground y-2)

(set-face-attribute 'font-lock-regexp-grouping-construct nil :foreground y-1 :weight 'bold)
(set-face-attribute 'font-lock-regexp-grouping-backslash nil :foreground text-3 :weight 'bold)

(set-face-attribute 'minibuffer-prompt  nil :foreground text-1)
(set-face-attribute 'vertical-border    nil :foreground surface-2)
(set-face-attribute 'mode-line          nil :foreground text-1 :background surface-2 :box `(:color ,text-3 :style nil))
(set-face-attribute 'mode-line-inactive nil :foreground text-3 :background surface-1 :box `(:color ,surface-3 :style nil))

(set-face-attribute 'ido-first-match nil :foreground y-1 :weight 'bold)
(set-face-attribute 'ido-subdir      nil :foreground y-2)
(set-face-attribute 'ido-only-match  nil :foreground y-1 :weight 'bold)

(defface font-lock-comment-note
  `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,g-1)))
  "NOTE comment highlighting")

(defface font-lock-comment-todo
  `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,r-0)))
  "TODO comment highlighting")

(defface font-lock-comment-important
  `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,y-1)))
  "IMPORTANT comment highlighting")

(defface font-lock-comment-nocheckin
  `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,c-0)))
  "NOCHECKIN comment highlighting")

(defface font-lock-comment-bug
  `((t (:inherit font-lock-comment-face :underline t :bold t :foreground ,m-0)))
  "BUG comment highlighting")

(defun highlight-comment-keywords ()
  (font-lock-add-keywords
   nil
   '(
     ("\\<\\(NOTE\\)\\>" 1 'font-lock-comment-note prepend) ; NOTE: Test comment.
     ("\\<\\(TODO\\)\\>" 1 'font-lock-comment-todo prepend) ; TODO: Test Comment.
     ("\\<\\(IMPORTANT\\)\\>" 1 'font-lock-comment-important prepend) ; IMPORTANT: Test Comment.
     ("\\<\\(NOCHECKIN\\)\\>" 1 'font-lock-comment-nocheckin prepend) ; NOCHECKIN: Test Comment.
     ("\\<\\(BUG\\)\\>" 1 'font-lock-comment-bug prepend) ; BUG: Test Comment.
     )))

(add-hook 'prog-mode-hook 'highlight-comment-keywords)

;; OS-dependent:
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
 '(package-selected-packages '(rainbow-mode)))
