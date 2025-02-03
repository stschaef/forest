;;; Mode for simple forester commands

;; (defun forester-new ()
;;   "Create a new tree."
;;   (interactive)
;;   (let
;;       ((default-directory "~/forest")
;;        (command "forester new forest.toml --dest=trees --prefix=sss"))
;;     (shell-command command)))

(defun forester-insert-title (file-path title)
  "Insert \\title{TITLE} at the top of the file specified by FILE-PATH."
  (interactive)
  (with-temp-buffer
    ;; Insert file contents into temp buffer
    (insert-file-contents file-path)
    ;; Move to beginning and insert our text
    (goto-char (point-min))
    (insert (format "\\title{%s}\n" title))
    ;; Write contents back to original file
    (write-region (point-min) (point-max) file-path)))

(defun forester-new-from-template (template title)
  "Create a new tree with the given TEMPLATE and TITLE and open the resulting file."
  (interactive)
  (let* ((default-directory "~/forest")
         (command (format "forester new forest.toml --prefix=sss --template=%s" (shell-quote-argument template)))
         ;; (command "forester new forest.toml --prefix=sss")
         (raw-output (shell-command-to-string command))
         (output-path (string-trim raw-output)))
    (forester-insert-title output-path title)
    (find-file output-path)))  ;; Opens the new file in a buffer

(defun forester-new-definition (title)
  "Create a new definition with TITLE and open the resulting file."
  (interactive "sTitle: ")
  (forester-new-from-template "definition" title)
  )

(defun forester-new-daily (title)
  "Create a new daily journal entry with TITLE and open the resulting file."
  (interactive "sTitle: ")
  (forester-new-from-template "daily" title)
  )

(defun forester-new (title)
  "Create a new tree with TITLE and open the resulting file."
  (interactive "sTitle: ")
  (forester-new-from-template "default" title))

(map! :leader
      (:prefix ("r" . "Forester")
       :desc "New tree" "n" #'forester-new
       :desc "New journal entry" "j" #'forester-new-daily
       :desc "New definition" "d" #'forester-new-definition
       ))

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

;; (defun forester-jump-tree ()
;;   (interactive)
;;   (counsel-file-jump (current-word) (projectile-project-root)))

;; (map! :n "g t" 'forester-jump-tree)
(map! :n "g t" 'my/projectile-find-file-at-point)


(define-derived-mode forester-mode fundamental-mode "Forester"
  "Major mode for editing Forester code."
  (setq comment-start "%")
  )

;; Define a setup function for Forester mode
(defun forester-mode-setup ()
  "Setup soft line wrap and other settings for Forester mode."
  (visual-line-mode 1))

;; Add the setup function to the Forester mode hook
(add-hook 'forester-mode-hook 'forester-mode-setup)

(add-to-list 'auto-mode-alist '("\\.tree" . forester-mode))

;; (require 'lsp-mode)

;; (defgroup lsp-forester nil
;;   "LSP support for the Forester language, using a custom language server."
;;   :group 'lsp-mode)

;; (defcustom lsp-forester-server-command '("forester" "lsp" "/Users/stevenschaefer/forest/forest.toml")
;;   "Command to start the Forester language server."
;;   :group 'lsp-forester
;;   :type '(repeat string))

;; (add-to-list 'lsp-language-id-configuration '(forester-mode . "Forester"))

;; (lsp-register-client
;;  (make-lsp-client
;;   :new-connection (lsp-stdio-connection lsp-forester-server-command)
;;   :major-modes '(forester-mode)
;;   :server-id 'forester-ls))

;; (add-hook 'forester-mode-hook #'lsp-deferred)

(provide 'forester)
;;; forest.el ends here
