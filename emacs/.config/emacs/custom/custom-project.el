;; ---------------------------------
;; PROJECT ROOT DETECTION
;; ---------------------------------

(require 'project)

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

(defun my-remember-poxel6-project ()
  "Remember custom poxel6 projects when visiting files."
  (when-let ((project (project-current)))
    (when (eq (car project) 'poxel6)
      (project-remember-project project))))

(add-hook 'project-find-functions #'my-poxel6-project-root -90)
(add-hook 'find-file-hook #'my-remember-poxel6-project)

