;;; Mode for simple forester commands

(defun forest-new ()
  "Create a new tree."
  (interactive)
  (let
      ((default-directory "~/forest")
       (command "forester new forest.toml --dest=trees --prefix=sss"))
    (shell-command command))))

(define-derived-mode forester-mode fundamental-mode "Forester"
  "Major mode for editing Forester code."
  )


(provide 'forester)
;;; forest.el ends here
