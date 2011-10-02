;; DESCRIPTION: fdelacruz settings

(add-to-list 'load-path dotfiles-dir)

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

;; Org-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-font-lock-mode 1)                     ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

;; Tramp-mode
(setq tramp-default-method "ssh")

;; Stop creating those backup~ files 
(setq make-backup-files nil) 

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

;; nXhtml
(load "~/.emacs.d/vendor/nxhtml/autostart")

;; Mumamo pesty warning fix
(when (and (equal emacs-major-version 23)
           (equal emacs-minor-version 3))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function))
  ;; tramp-compat.el clobbers this variable!
  (eval-after-load "tramp-compat"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function)))
