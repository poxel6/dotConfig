(require 'package)
(require 'project)
(require 'uniquify)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(defalias 'yes-or-no-p 'y-or-n-p)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

(setq indent-tabs-mode nil
      tab-always-indent t
      tab-width 4)

(setq search-default-mode t
      duplicate-line-final-position -1
      auto-save-default nil
      delete-selection-mode 1
      global-auto-revert-non-file-buffers t
      history-length 25
      ispell-dictionary "en_US"
      switch-to-buffer-obey-display-actions t
      treesit-font-lock-level 4
      truncate-lines t
      uniquify-buffer-name-style 'forward
      compilation-always-kill t)

(setq display-line-numbers-width 4
      display-line-numbers-width-start t
      display-line-numbers-type 'relative)

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

(setq dired-listing-switches "-Alh --group-directories-first --sort=none"
      dired-kill-when-opening-new-dired-buffer t
      dired-dwim-target t
      dired-guess-shell-alist-user
      '(("\\.mp4\\'" "mpv")
        ("\\.png\\|\\.jpg\\|\\.jpeg\\'" "imv")))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "N")
              #'dired-create-empty-file))


(setq custom-file (expand-file-name "init.custom.el" user-emacs-directory))
(load-file custom-file)

(load "custom-c-mode")
(load "custom-project")
(load "custom-languages")
  
(global-set-key (kbd "C-c h") #'vc-diff)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x r c") 'delete-whitespace-rectangle)
(global-set-key (kbd "C-S-d") 'duplicate-line)
(global-set-key (kbd "M-[")
                (lambda ()
                  (interactive)
                  (let ((default-directory
                         (project-root (project-current))))
                    (project-recompile))))
(global-set-key (kbd "M-j") (lambda () (interactive) (delete-indentation t)))
(global-set-key (kbd "M-<up>")
                (lambda ()
                  (interactive)
                  (transpose-lines 1)
		  (forward-line -2)))

(global-set-key (kbd "M-<down>")
                (lambda ()
                  (interactive)
                  (forward-line 1)
                  (transpose-lines 1)
                  (forward-line -1)))

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
;; UI / FRAME SETTINGS
;; ---------------------------------


(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(winner-mode 1)
(savehist-mode t)
(set-fringe-mode 4)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

(ido-mode t)
(fido-mode t)
(setq ido-everywhere t
      ido-enable-flex-matching t)

;; (set-frame-font "IosevkaNerdFontMono-Regular 20" nil t)

(set-face-attribute 'default nil
                    :family "Hack Nerd Font Mono"
                    :height 140
		    :background "#282c34")

(set-face-attribute 'line-number-current-line nil
		    :background 'unspecified
		    :foreground
		    (face-attribute 'font-lock-keyword-face :foreground nil t)
		    :bold t
		    :extend t)

(defun my-special-buffer-font ()
  (face-remap-add-relative 'default :height 140))

(add-hook 'compilation-mode-hook #'my-special-buffer-font)
(add-hook 'help-mode-hook #'my-special-buffer-font)
(add-hook 'special-mode-hook #'my-special-buffer-font)

(setq split-width-threshold 0
      even-window-sizes nil
      pop-up-frames nil
      display-buffer-alist
      '(("\\*\\(Help\\|compilation\\|Warnings\\|Backtrace\\|Occur\\|xref\\).*"
         (display-buffer-in-side-window)
	 (side . right)
	 (slot . 0)
	 (window-width . 0.5))))

(setq scroll-margin 10
      scroll-conservatively 10
      scroll-preserve-screen-position t
      next-screen-context-lines 5
      pixel-scroll-precision-mode t
      pixel-scroll-precision-use-momentum nil)

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
;; ORG MODE
;; ---------------------------------

(with-eval-after-load 'org
  (setq org-agenda-window-setup 'current-window))

(setq org-agenda-files '("~/inbox.org"))
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/inbox.org" "Inbox")
         "* TODO %?\n")))

(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c i") (lambda ()
				(interactive)
				(find-file "~/inbox.org")))
(global-set-key (kbd "C-c c") (lambda ()
				(interactive)
				(org-capture)))
(global-set-key (kbd "C-c d")
                (lambda ()
                  (interactive)
                  (insert (format-time-string "%F"))))

(with-eval-after-load 'org-faces
  (set-face-attribute 'org-level-1 nil
                      :family "Inter Display"
                      :foreground "#51afef"
                      :weight 'bold
                      :height 220)

  (set-face-attribute 'org-level-2 nil
                      :family "Hack Nerd Font Mono"
                      :foreground "#c678dd")

  (set-face-attribute 'org-table nil
                      :family "Inter"
                      :height 160)

  (set-face-attribute 'org-todo nil
                      :foreground "#c73c3f"
                      :weight 'bold)

  (set-face-attribute 'org-done nil
                      :foreground "#73c936"
                      :weight 'bold))

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
   ("C-c C->" . mc/mark-all-like-this-dwim)))

;; ---------------------------------
;; THEMES
;; ---------------------------------

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker nil)
  )

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-ayu-mirage t)
  (set-face-attribute 'line-number-current-line
		      nil
		      :background 'unspecified
		      :foreground
		      (face-attribute 'font-lock-keyword-face :foreground nil t)
		      :bold t
		      :extend t))

;; ---------------------------------
;; GHOSTEL
;; ---------------------------------

(use-package ghostel
  :ensure t
  :bind (("C-c s" . ghostel))
  :config
  (setq ghostel-initial-input-mode 'line)
  (add-to-list 'project-switch-commands
               '(ghostel-project "Ghostel") t))

(use-package ghostel-compile
  :ensure nil
  :hook (after-init . ghostel-compile-global-mode))

(use-package ghostel-comint
  :hook
  (after-init . ghostel-comint-global-mode))

(use-package ghostel-eshell
  :ensure nil
  :hook
  (eshell-load . ghostel-eshell-visual-command-mode))

;; ---------------------------------
;; PACKAGES
;; ---------------------------------

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


(use-package diff-hl
  :ensure t
  :hook
  ((prog-mode . diff-hl-mode)
   (vc-dir-mode . diff-hl-dir-mode))
  :config
  (global-diff-hl-show-hunk-mouse-mode 1)
  (set-face-attribute 'diff-hl-insert nil :background "#3fb950")
  (set-face-attribute 'diff-hl-delete nil :background "#f85149")
  (set-face-attribute 'diff-hl-change nil :background "#d29922"))

(use-package helpful
  :ensure t
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h x" . helpful-command)))

(use-package diredfl
  :hook
  (dired-mode . diredfl-mode))

(use-package completion-preview
  :ensure nil
  :hook
  (prog-mode . completion-preview-mode)

  :bind
  (:map completion-preview-active-mode-map
        ("M-n" . completion-preview-next-candidate)
        ("M-p" . completion-preview-prev-candidate)
        ("TAB" . completion-preview-insert)
        ("RET" . completion-preview-insert)))

