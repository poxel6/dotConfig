;; ---------------------------------
;; C / C++ MODE
;; ---------------------------------

(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (electric-indent-local-mode 1)))

(setq c-hanging-braces-alist
      '((substatement-open after)))

(defun my-c-ts-mode-setup ()
  (setq-local c-ts-mode-indent-style 'k&r)
  (setq-local c-ts-mode-indent-offset 4)
  (setq-local c-ts-indent-offset 4)
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 4)
  (setq-local c-auto-align-backslashes t)

  (electric-indent-local-mode 1)
  (electric-pair-mode 1))

(add-hook 'c-ts-mode-hook #'my-c-ts-mode-setup)

(with-eval-after-load 'cc-mode
  (setq c-default-style "k&r")
  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-auto-align-backslashes t)
  (electric-pair-mode 1))

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
  (define-key c-ts-mode-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c-ts-mode-map (kbd "C-c C-o") #'my-ff-find-other-file))

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
   "{BasedOnStyle: Google,
AlignArrayOfStructures: Left,
IndentWidth: 4,
BinPackParameters: false,
BinPackArguments: false,
AllowShortFunctionsOnASingleLine: None,
AllowShortBlocksOnASingleLine: Never,
AllowShortIfStatementsOnASingleLine: Never,
AllowShortLoopsOnASingleLine: false,
AllowShortEnumsOnASingleLine: false,
AllowAllParametersOfDeclarationOnNextLine: false,
PointerAlignment: Left,
IndentCaseLabels: false}")
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

(with-eval-after-load 'c-ts-mode
  (define-key c-ts-mode-map (kbd "C-c C-p")
	      #'my-c-extract-prototype-to-header))
