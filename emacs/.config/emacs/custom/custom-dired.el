;; ---------------------------------
;; Dired 
;; ---------------------------------

(setq dired-listing-switches "-Alh --group-directories-first --sort=none")
(setq dired-kill-when-opening-new-dired-buffer t)
(setq dired-dwim-target t)
(setq dired-guess-shell-alist-user
      '(("\\.mp4\\'" "mpv")
        ("\\.png\\|\\.jpg\\|\\.jpeg\\'" "imv")))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "N")
              #'dired-create-empty-file))
(require 'project)
(use-package diredfl
  :hook
  (dired-mode . diredfl-mode))
