;; ---------------------------------
;; EGLOT / LSP
;; ---------------------------------

(use-package eglot
  :ensure nil
  :hook ((c-ts-mode . eglot-ensure)
   (rust-ts-mode . eglot-ensure)
   (rust-mode . eglot-ensure))

  :bind (:map eglot-mode-map
	      ("M-RET" . eglot-code-actions))
  :config
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (eglot-inlay-hints-mode -1))))

(use-package rust-mode
  :ensure nil
  :mode "\\.rs\\'")

(with-eval-after-load 'eglot
  (add-to-list
   'eglot-server-programs
   '((rust-mode) .
     ("rust-analyzer" :initializationOptions 
      (:check (:command "clippy"))))))


