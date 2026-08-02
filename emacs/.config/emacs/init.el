(package-initialize)



(require 'package)
(require 'project)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(setq custom-file "~/.config/emacs/emacs.custom.el")
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq inhibit-splash-screen t)
(setq tab-always-indent 'complete)
(setq duplicate-line-final-position -1)

(load-file custom-file)
;; ---------------------------------
;; Org Mode
;; ---------------------------------

(setq org-agenda-files '("~/inbox.org"))
(global-set-key (kbd "C-c a") #'org-agenda)

(global-set-key (kbd "C-c i") (lambda ()
				(interactive)
				(find-file "~/inbox.org")))

(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/inbox.org" "Inbox")
         "* TODO %?\n")))

(global-set-key (kbd "C-c c") (lambda ()
				(interactive)
				(org-capture)))

(global-set-key (kbd "C-c d")
                (lambda ()
                  (interactive)
                  (insert (format-time-string "%F"))))

(custom-set-faces
 '(org-level-1 ((t (:foreground "#51afef"))))
 '(org-level-2 ((t (:foreground "#c678dd"))))
 '(org-level-3 ((t (:foreground "#a9a1e1"))))
 '(org-level-4 ((t (:foreground "#7cc3f3"))))
 '(org-level-5 ((t (:foreground "#d499e5"))))
 '(org-level-6 ((t (:foreground "#a8d7f7"))))
 '(org-level-7 ((t (:foreground "#e2bbee"))))
 '(org-todo ((t (:foreground "#c73c3f" :weight bold))))
 '(org-done ((t (:foreground "#73c936" :weight bold)))))

;; ---------------------------------
;; UI / FRAME SETTINGS
;; ---------------------------------

(setq display-line-numbers-type 'relative)
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(fido-mode 1)

(set-frame-font "IosevkaNFM 20" nil t)

(global-display-line-numbers-mode 1)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(global-hl-line-mode 1)

;; ---------------------------------
;; WINDOW / BUFFER DISPLAY
;; ---------------------------------

(add-to-list
 'display-buffer-alist
 '("\\*\\(compilation\\)\\*"
   (display-buffer-reuse-window
    display-buffer-use-some-window
    display-buffer-pop-up-window)
   (inhibit-same-window . t)))

;; ---------------------------------
;; SCROLLING
;; ---------------------------------

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
;; PROJECT ROOT DETECTION
;; ---------------------------------

(defun my-poxel6-project-root (dir)
  "Find a poxel6 project root from DIR."
  (let* ((dir (file-name-as-directory (expand-file-name dir)))
	 (base (file-name-as-directory (expand-file-name "~/poxel6")))
	 (code (expand-file-name "code/" base))
	 (scratch (expand-file-name "scratch/" base))
	 (third-party (expand-file-name "third-party/" base))
	 (root nil))

    (cond
     ;; ~/poxel6/code/<project>/**
     ((file-in-directory-p dir code)
      (let ((candidate
             (expand-file-name
              (car (file-name-split
                    (file-relative-name dir code)))
              code)))
	(when (and (file-directory-p candidate)
		   (not (file-equal-p candidate code)))
	  (setq root candidate))))

     ;; ~/poxel6/scratch/<language>/<project>/**
     ((file-in-directory-p dir scratch)
      (let* ((parts (file-name-split
                     (file-relative-name dir scratch)))
             (language (nth 0 parts))
             (project (nth 1 parts)))
	(when (and language project)
	  (let ((candidate
		 (expand-file-name
		  project
		  (expand-file-name language scratch))))
            (when (file-directory-p candidate)
              (setq root candidate))))))

     ;; ~/poxel6/third-party/<project>/**
     ((file-in-directory-p dir third-party)
      (let ((candidate
             (expand-file-name
              (car (file-name-split
                    (file-relative-name dir third-party)))
              third-party)))
	(when (and (file-directory-p candidate)
		   (not (file-equal-p candidate third-party)))
	  (setq root candidate)))))

    (when root
      (cons 'poxel6 root))))

(cl-defmethod project-root ((project (head poxel6)))
  (cdr project))

(add-hook 'project-find-functions #'my-poxel6-project-root -90)

;; ---------------------------------
;; PROJECT RECOMPILATION
;; ---------------------------------

(defun my-project-recompile ()
  (interactive)
  (let ((default-directory
	 (project-root (project-current))))
    (recompile)))

(global-set-key (kbd "M-m") #'my-project-recompile)

;; ---------------------------------
;; C / C++ MODE
;; ---------------------------------

;; C / C++ indentation
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (electric-indent-local-mode 1)))

(setq c-hanging-braces-alist
      '((substatement-open after)))

(with-eval-after-load 'cc-mode
  (setq c-default-style "k&r")
  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-auto-align-backslashes t)
  (electric-pair-mode 1)

  (define-key c-mode-base-map (kbd "RET") #'c-context-line-break)
  (define-key c-mode-base-map (kbd "C-o") #'c-context-open-line))

;; ---------------------------------
;; C / C++ FILE SWITCHING
;; ---------------------------------

(setq ff-search-directories
      '("." "../include" "../src" "../include/*" "../src/*"))

(setq ff-other-file-alist
      '(("\\.c\\'" (".h"))
	("\\.h\\'" (".c"))
	("\\.cpp\\'" (".hpp" ".h"))
	("\\.hpp\\'" (".cpp" ".c"))))

(defun my-ff-find-other-file ()
  (interactive)
  (let ((ff-always-in-other-window t))
    (ff-find-other-file)))

(with-eval-after-load 'c-ts-mode
  (define-key c-ts-mode-map (kbd "C-c o") 'ff-find-other-file)
  (define-key c-ts-mode-map (kbd "C-c -o") #'my-ff-find-other-file))

(with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c-mode-base-map (kbd "C-c C-o") #'my-ff-find-other-file))

;; ---------------------------------
;; CLANG-FORMAT
;; ---------------------------------

(use-package clang-format
  :ensure t
  :custom
  (clang-format-style
   (concat "file:" (expand-file-name "~/.config/clang-format/.clang-format")))
  :bind
  (("C-c f" . clang-format-buffer)))

;; ---------------------------------
;; C / C++ FUNCTION PROTOTYPE EXTRACTION
;; ---------------------------------

(require 'subr-x)

(defun my-c--current-function-prototype ()
  (save-excursion
    (when (bolp)
      (forward-char 1))
    (c-beginning-of-defun)
    (let ((beg (point)))
      (c-end-of-defun)
      (let* ((src (buffer-substring-no-properties beg (point)))
	     (brace (string-match "{" src)))
	(unless brace
	  (user-error "Could not find function body"))
	(let* ((sig (string-trim (substring src 0 brace)))
	       (proto (replace-regexp-in-string "[[:space:]\n\r\t]+" " " sig)))
	  (unless (string-match
		   "\\([*[:alpha:]][*[:alnum:]]*\\)\\s-*(" proto)
	    (user-error "Could not find function name"))
	  (list proto (match-string 1 proto)))))))

(defun my-c--project-header-file ()
  (let* ((file (buffer-file-name))
	 (ext (downcase (or (file-name-extension file) ""))))
    (cond
     ((string-match "/src/" file)
      (let* ((root (substring file 0 (match-beginning 0)))
	     (rel (substring file (match-end 0)))
	     (newext (if (string= ext "cpp") "hpp" "h")))
	(expand-file-name
	 (concat (file-name-sans-extension rel) "." newext)
	 (concat root "/include/"))))
     (t
      (expand-file-name
       (concat (file-name-sans-extension (file-name-nondirectory file))
	       "." (if (string= ext "cpp") "hpp" "h"))
       (file-name-directory file))))))

(defun my-c--prototype-present-p (name)
  (save-excursion
    (goto-char (point-min))
    (re-search-forward
     (concat "^\\s-*.*\\_<" 
	     (regexp-quote name)
	     "\\_>\\s-*([^;{]*);")
     nil t)))

(defun my-c-extract-prototype-to-header ()
  (interactive)
  (unless (derived-mode-p 'c-mode 'c++-mode)
    (user-error "Use this in C/C++ mode"))
  (pcase-let* ((`(,proto ,name) (my-c--current-function-prototype))
	       (header (my-c--project-header-file))
	       (buf (find-file-noselect header)))
    (with-current-buffer buf
      (unless (my-c--prototype-present-p name)
	(goto-char (point-max))
	(unless (bolp) (insert "\n"))
	(insert proto ";\n")
	(save-buffer)))
    (display-buffer buf
		    '((display-buffer-reuse-window
		       display-buffer-in-side-window)
		      (side . right)
		      (slot . 0)
		      (window-width . 0.5)))
    (message "Inserted prototype for %s into %s" name header)))

(with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "C-c C-p")
	      #'my-c-extract-prototype-to-header))

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
;; COMPLETION
;; ---------------------------------
;; (load-file "~/dotConfig/emacs/.config/emacs/completion.el")

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
;; THEME
;; ---------------------------------

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

;; ---------------------------------
;; WHICH-KEY
;; ---------------------------------

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :hook (after-init . which-key-mode)
  :custom
  (which-key-idle-delay 3)
  (which-key-secondary-delay 3)
  (which-key-max-display-columns nil)
  (which-key-sort-order #'which-key-key-order-alpha)
  (which-key-max-description-length 40)
  (which-key-side-window-location 'bottom))

;; ---------------------------------
;; MAGIT
;; ---------------------------------

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :custom
  (magit-display-buffer-function
   #'magit-display-buffer-same-window-except-diff-v1)
  (magit-save-repository-buffers 'dontask))
