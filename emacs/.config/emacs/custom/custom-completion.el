;; ---------------------------------
;; COMPLETION-PREVIEW
;; ---------------------------------

;; (use-package completion-preview
;;   :ensure nil
;;   :hook (prog-mode . completion-preview-mode)
;;   :config
;;   (global-completion-preview-mode 1)
;;   (define-key completion-preview-active-mode-map
;; 	      (kbd "M-n")
;; 	      #'completion-preview-next-candidate)
;;   (define-key completion-preview-active-mode-map
;; 	      (kbd "M-p")
;; 	      #'completion-preview-prev-candidate))

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
