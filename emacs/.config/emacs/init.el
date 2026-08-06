(package-initialize)

(require 'package)
(require 'project)
(require 'uniquify)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq search-default-mode t)
(setq duplicate-line-final-position -1)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(setq custom-file (expand-file-name "init.custom.el" user-emacs-directory))
(load-file custom-file)

(load "custom-c-mode")
(load "custom-dired")
(load "custom-org-mode")
(load "custom-project")

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-/") 'hippie-expand)

;; ---------------------------------
;; UI / FRAME SETTINGS
;; ---------------------------------

(setq split-height-threshold nil
      split-width-threshold 0)

(setq uniquify-buffer-name-style 'forward)
(setq vc-follow-symlinks t)

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-starup-message nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(winner-mode 1)
(savehist-mode t)

(ido-mode t)
(fido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;; (set-frame-font "IosevkaNerdFontMono-Regular 20" nil t)

(set-face-attribute 'default nil
                    :family "Iosevka NFM"
                    :height 180)

(global-display-line-numbers-mode 1)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(global-hl-line-mode 1)
(setq display-line-numbers-type 'relative)

(setq even-window-sizes nil)
(setq pop-up-windows nil)
(setq display-buffer-alist
      '(("\\*\\(Help\\|compilation\\|Warnings\\|Backtrace\\|Occur\\|xref\\).*"
         (display-buffer-in-side-window
	  display-buffer-same-window)
	 (side . right)
	 (slot . 0)
	 (window-width . 0.5))))

(setq scroll-margin 10
      scroll-conservatively 101
      scroll-preserve-screen-position t
      next-screen-context-lines 5)

(defun my-scroll-down ()
  (interactive)
  (scroll-up-command (/ (window-body-height) 2))
  (recenter))

(defun my-scroll-up ()
  (interactive)
  (scroll-down-command (/ (window-body-height) 2))
  (recenter))

(global-set-key (kbd "C-v") #'my-scroll-down)
(global-set-key (kbd "M-v") #'my-scroll-up)

;; ---------------------------------
;; TODO HIGHLITING
;; ---------------------------------

(defface my-fixme-face
  '((t (:foreground "#ff6c6b" :weight bold)))
  "Face for FIXME and BUG.")

(defface my-todo-face
  '((t (:foreground "#ecbe7b" :weight bold)))
  "Face for TODO.")

(defface my-hack-face
  '((t (:foreground "#d19a66" :weight bold)))
  "Face for HACK and OPTIMIZE.")

(defface my-note-face
  '((t (:foreground "#51afef" :weight bold)))
  "Face for NOTE.")

(defun my-c-ts-highlight-todos ()
  (font-lock-add-keywords
   nil
   '(("//[ \t]*\\(FIXME\\|BUG\\):"
      1 'my-fixme-face prepend)
     ("//[ \t]*\\(TODO\\):"
      1 'my-todo-face prepend)
     ("//[ \t]*\\(HACK\\|OPTIMIZE\\):"
      1 'my-hack-face prepend)
     ("//[ \t]*\\(NOTE\\):"
      1 'my-note-face prepend))))

(add-hook 'c-ts-mode-hook #'my-c-ts-highlight-todos)

;; ---------------------------------
;; COMPLETION-PREVIEW
;; ---------------------------------

(use-package completion-preview
  :ensure nil
  :hook (prog-mode . completion-preview-mode)
  :config
  (global-completion-preview-mode 1)
  (define-key completion-preview-active-mode-map
	      (kbd "M-n")
	      #'completion-preview-next-candidate)
  (define-key completion-preview-active-mode-map
	      (kbd "M-p")
	      #'completion-preview-prev-candidate))

;; ---------------------------------
;; EGLOT / C / C++ LANGUAGE SERVER
;; ---------------------------------

(use-package eglot
  :ensure nil
  :hook ((c-mode . eglot-ensure)
	 (c++-mode . eglot-ensure))
  :config
  (setq eglot-inlay-hints-mode nil))

;; ---------------------------------
;; MULTIPLE CURSORS
;; ---------------------------------

(use-package multiple-cursors
  :ensure t
  :config
  :bind
  (("C-<" . mc/mark-previous-like-this)
   ("C->" . mc/mark-next-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-c C->" . mc/mark-all-like-this-dwim)
   ("C-S-d" . duplicate-line)))

;; ---------------------------------
;; THEMES
;; ---------------------------------

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker nil))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-ayu-dark t)
  (set-face-attribute 'line-number-current-line nil
		      :background 'unspecified
		      :foreground
		      (face-attribute 'font-lock-keyword-face :foreground nil t)
		      :bold t
		      :extend t))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :hook (after-init . which-key-mode)
  :custom
  (which-key-idle-delay 2)
  (which-key-secondary-delay 2)
  (which-key-max-display-columns nil)
  (which-key-sort-order #'which-key-key-order-alpha)
  (which-key-max-description-length 40)
  (which-key-side-window-location 'bottom))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :custom
  (magit-display-buffer-function
   #'magit-display-buffer-same-window-except-diff-v1)
  (magit-save-repository-buffers 'dontask))

(use-package ghostel
  :ensure t
  :bind (("C-c s" . ghostel)))
