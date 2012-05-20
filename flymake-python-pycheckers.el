(setq flymake-log-level 1)
(add-to-list 'load-path (concat dotfiles-dir "/vendor/flymake-cursor.el"))

(require 'flymake-cursor)
(global-set-key [f4] 'flymake-goto-next-error)

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file)))) ;; shell script in ~/bin

  (add-to-list 'flymake-allowed-file-name-masks
                            '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)

