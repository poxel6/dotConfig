;;                                                              
;; Completion UI: Corfu
;;                                                              

(use-package corfu
  :ensure t
  :custom
  ;; Show completion automatically, like blink.cmp.
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 1)

  ;; Blink: max_height = 9
  (corfu-count 9)

  ;; Blink: no scrollbar
  (corfu-scroll-margin 2)

  ;; Keep the currently selected candidate visible.
  (corfu-preview-current t)

  ;; Don't force completion if there is only one candidate.
  (corfu-preselect 'prompt)

  ;; Keep the popup close to Blink's width.
  (corfu-min-width 50)
  (corfu-max-width 50)

  :init
  (global-corfu-mode))


;;
;; Completion icons: kind-icon
;;

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  ;; Make icons inherit Corfu's appearance.
  (kind-icon-default-face 'corfu-default)

  ;; Similar visual size to a compact completion icon.
  (kind-icon-default-style
   '(:padding 0
     :stroke 0
     :margin 0
     :radius 0
     :height 0.9
     :scale 0.75))

  ;; Slightly blend the icon with the completion background.
  (kind-icon-blend-frac 0.08)

  :config
  ;; Display the kind icon and kind name on the right side.
  ;;
  ;; Result:
  ;;
  ;;   printf                         󰊕  Function
  ;;   variable_name                  󰀫  Variable
  ;;   MyStruct                         Struct
  ;;
  (defun my/corfu-kind-annotation (candidate)
    "Return the kind icon and kind name for CANDIDATE."
    (let* ((kind (get-text-property 0 'company-kind candidate))
           (kind-name
            (pcase kind
              ('text "Text")
              ('method "Method")
              ('function "Function")
              ('constructor "Constructor")
              ('field "Field")
              ('variable "Variable")
              ('class "Class")
              ('interface "Interface")
              ('module "Module")
              ('property "Property")
              ('unit "Unit")
              ('value "Value")
              ('enum "Enum")
              ('keyword "Keyword")
              ('snippet "Snippet")
              ('color "Color")
              ('file "File")
              ('reference "Reference")
              ('folder "Folder")
              ('constant "Constant")
              ('struct "Struct")
              ('event "Event")
              ('operator "Operator")
              ('type-parameter "Type Parameter")
              (_ nil)))
           (icon
            (when kind
              (kind-icon-formatted
               (propertize candidate
                           'company-kind kind))))
      (when (or icon kind-name)
        (concat
         (when icon
           (concat icon "  "))
         (or kind-name ""))))))

  ;; Add the annotation function to Corfu.
  ;;
  ;; This puts the icon + kind name on the right side
  ;; without modifying the actual completion candidate.
  (add-to-list
   'completion-extra-properties
   :annotation-function #'my/corfu-kind-annotation))


;;
;; Optional: richer completion sources
;;

(use-package cape
  :ensure t
  :init
  ;; Add buffer completion as a fallback alongside LSP.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)

  ;; File path completion.
  (add-to-list 'completion-at-point-functions #'cape-file))

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

