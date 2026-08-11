(require 'package)
(require 'project)
(require 'uniquify)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

(setq indent-tabs-mode nil
      tab-always-indent t
      tab-width 4)

(setq search-default-mode t)
(setq duplicate-line-final-position -1)
(setq auto-save-default nil)
(setq delete-selection-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq history-length 25)
(setq ispell-dictionary "en_US")
(setq switch-to-buffer-obey-display-actions t)
(setq treesit-font-lock-level 4)
(setq truncate-lines t)
(setq uniquify-buffer-name-style 'forward)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-width 3
      display-line-numbers-type 'relative)
(global-hl-line-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)
(setq use-dialog-box nil
      use-short-answers t
      vc-follow-symlinks t
      warning-minimum-level :emergency)

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-starup-message nil)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(setq custom-file (expand-file-name "init.custom.el" user-emacs-directory))
(load-file custom-file)

(load "custom-c-mode")
(load "custom-dired")
(load "custom-org-mode")
(load "custom-project")
(load "custom-completion")
(load "custom-languages")

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x r c") 'delete-whitespace-rectangle)
(global-set-key (kbd "M-[")
                (lambda ()
                  (interactive)
                  (let ((default-directory
                         (project-root (project-current))))
                    (project-recompile))))
(global-set-key (kbd "M-j")
		(lambda ()
		  (interactive)
		  (delete-indentation t)))

;; ---------------------------------
;; UI / FRAME SETTINGS
;; ---------------------------------


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
                    :height 160)
(setq split-width-threshold 0
      even-window-sizes nil
      pop-up-frames nil
      display-buffer-alist
      '(("\\*\\(Help\\|compilation\\|Warnings\\|Backtrace\\|Occur\\|xref\\).*"
         (display-buffer-in-side-window
	  display-buffer-same-window)
	 (side . right)
	 (slot . 0)
	 (window-width . 0.5))))

(setq scroll-margin 10
      scroll-conservatively 10
      scroll-preserve-screen-position t
      next-screen-context-lines 5
      pixel-scroll-precision-mode t
      pixel-scroll-precision-use-momentum nil)

(global-set-key (kbd "C-v")
                (lambda ()
                  (interactive)
                  (scroll-up-command (/ (window-body-height) 2))
                  (recenter)))

(global-set-key (kbd "M-v")
                (lambda ()
                  (interactive)
                  (scroll-down-command (/ (window-body-height) 2))
                  (recenter)))

(global-set-key (kbd "C-M-v")
                (lambda ()
                  (interactive)
                  (scroll-other-window (/ (window-body-height) 2))))

(global-set-key (kbd "C-M-S-v")
                (lambda ()
                  (interactive)
                  (scroll-other-window (- (/ (window-body-height) 2)))))

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

(defun my-highlight-todos ()
  (font-lock-add-keywords
   nil
   '(("/[/*][ \t]*\\(FIXME\\|BUG\\):" 1 'my-fixme-face prepend)
     ("/[/*][ \t]*\\(TODO\\):" 1 'my-todo-face prepend)
     ("/[/*][ \t]*\\(HACK\\|OPTIMIZE\\):" 1 'my-hack-face prepend)
     ("/[/*][ \t]*\\(NOTE\\):" 1 'my-note-face prepend))))

(add-hook 'prog-mode-hook #'my-highlight-todos)

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
  (load-theme 'doom-ayu-mirage t)
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
