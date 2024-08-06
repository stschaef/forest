;;; Mode for simple forester commands

(defun forest-new ()
  "Create a new tree."
  (interactive)
  (let
      ((default-directory "~/forest")
       (command "forester new forest.toml --dest=trees --prefix=sss"))
    (shell-command command)))

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
