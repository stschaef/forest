;;; Mode for simple forester commands

(defun forester-new ()
  "Create a new tree."
  (interactive)
  (let
      ((default-directory "~/forest")
       (command "forester new forest.toml --dest=trees --prefix=sss"))
    (shell-command command)))

(map! :leader
      "f n" 'forester-new)

(defun my/projectile-find-file-at-point ()
  "Use `projectile-find-file' to search for the word at point and open the best matching file."
  (interactive)
  (let* ((current-word (thing-at-point 'word t))
         (project-files (projectile-current-project-files))
         (matching-files (seq-filter (lambda (file)
                                       (string-match-p (regexp-quote current-word) file))
                                     project-files)))
    (if matching-files
        (find-file (projectile-expand-root (car matching-files)))
      (message "No matching files found for: %s" current-word))))

(defun forester-jump-tree ()
  (interactive)
  (counsel-file-jump (current-word) (projectile-project-root)))

;; (map! :n "g t" 'forester-jump-tree)
(map! :n "g t" 'my/projectile-find-file-at-point)

(define-derived-mode forester-mode fundamental-mode "Forester"
  "Major mode for editing Forester code."
  )

;; Define a setup function for Forester mode
(defun forester-mode-setup ()
  "Setup soft line wrap and other settings for Forester mode."
  (visual-line-mode 1))

;; Add the setup function to the Forester mode hook
(add-hook 'forester-mode-hook 'forester-mode-setup)

(add-to-list 'auto-mode-alist '("\\.tree\\'" . forester-mode))

(provide 'forester)
;;; forest.el ends here
