;; DESCRIPTION: fdelacruz settings

(add-to-list 'load-path dotfiles-dir)

;; Don't make backup~ files 
(setq make-backup-files nil) 

;; Color Theme
(add-to-list 'load-path (concat dotfiles-dir "/vendor/color-theme/"))
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)

;; Snippets
(add-to-list 'load-path (concat dotfiles-dir "/vendor/yasnippet"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")

;; Scala-mode
(add-to-list 'load-path (concat dotfiles-dir "/vendor/scala-mode"))
(require 'scala-mode-auto)

(setq yas/my-directory "~/.emacs.d/vendor/scala-mode/contrib/yasnippet/snippets")
  (yas/load-directory yas/my-directory)

(add-hook 'scala-mode-hook
          '(lambda ()
             (yas/minor-mode-on)))

;; Org-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-font-lock-mode 1)                     ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

;; Tramp-mode
(setq tramp-default-method "ssh")


;; Invoke M-x without the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; M-x compile for cpp files
(add-hook 'c++-mode-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   (let ((file (file-name-nondirectory buffer-file-name)))
                     (format "%s -o %s %s %s"
                             (or (getenv "CC") "g++")
                             (file-name-sans-extension file)
                             (or (getenv "CFLAGS") "-Wall -gstabs")
                             file))))))

;; M-x compile for java files
(add-hook 'java-mode-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   (let ((file (file-name-nondirectory buffer-file-name)))
                     (format "%s %s"
                             (or  "javac")
                             file))))))

;; Macros
(fset 'TiJ4CodeFix
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("version1.56version1.56J2SE5f61.5ff6" 0 "%d")) arg)))

;; nXhtml (beta 2.09, revision 834)
(add-hook 'html-mode-hook (lambda ()
(progn
  (load-file "~/.emacs.d/vendor/~nxhtml/nxhtml/main/autostart.el")
))) 
                                
;; Auto-Complete-mode
(add-to-list 'load-path (concat dotfiles-dir "/vendor/auto-complete"))
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/ac-dict")

;; python-mode.el
(add-to-list 'load-path (concat dotfiles-dir "/vendor/python-mode.el"))
(setq py-install-directory "~/.emacs.d/vendor/python-mode.el")
(require 'python-mode)
  
;; Python sintax/error highlighting 
(setq flymake-log-level 2)          
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

;; Magit
(add-to-list 'load-path (concat dotfiles-dir "/vendor/magit"))
(require 'magit)
