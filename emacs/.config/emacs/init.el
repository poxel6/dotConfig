(setq custom-file "~/.config/emacs/emacs.custom.el")
(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)

(fido-mode 1)
(fido-vertical-mode 1)
(set-frame-font "IosevkaNFM 20" nil t)
(setq inhibit-compacting-font-caches t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(global-hl-line-mode 1)

(setq treesit-language-source-alist
      '((c   . ("https://github.com/tree-sitter/tree-sitter-c"))
        (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))))

(setq major-mode-remap-alist
      '((c-mode   . c-ts-mode)
        (c++-mode . c++-ts-mode)))

(use-package eglot
  :ensure nil
  :hook ((c-ts-mode . eglot-ensure)
         (c++-ts-mode . eglot-ensure)))

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'doom-one t)

  ;; Optional extras
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package nerd-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 30)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-minor-modes nil))

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  :init
  (global-corfu-mode)
  :config
  (corfu-popupinfo-mode))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters
               #'nerd-icons-corfu-formatter))

(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles partial-completion)))))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :hook (after-init . which-key-mode)
  :custom
  ;; How long to wait before showing the popup.
  (which-key-idle-delay 0.3)

  ;; Show the popup almost immediately after continuing a key sequence.
  (which-key-idle-secondary-delay 0.05)

  ;; Better use of horizontal space.
  (which-key-max-display-columns nil)

  ;; Sort alphabetically.
  (which-key-sort-order #'which-key-key-order-alpha)

  ;; Don't make the popup too tall.
  (which-key-max-description-length 40)

  ;; Side window at the bottom.
  (which-key-side-window-location 'bottom))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :custom
  (magit-display-buffer-function
   #'magit-display-buffer-same-window-except-diff-v1)
  (magit-save-repository-buffers 'dontask))
