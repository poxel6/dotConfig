;; ---------------------------------
;; Org Mode
;; ---------------------------------

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
                      :family "Iosevka NFM"
                      :foreground "#c678dd"
                      :weight 'medium
                      :height 200)

  (set-face-attribute 'org-table nil
                      :family "Inter"
                      :height 160)

  (set-face-attribute 'org-todo nil
                      :foreground "#c73c3f"
                      :weight 'bold)

  (set-face-attribute 'org-done nil
                      :foreground "#73c936"
                      :weight 'bold))
