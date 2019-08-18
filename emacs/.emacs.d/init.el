;;; Package management
(require 'package)
(setq package-archives '(("tromey" . "http://tromey.com/elpa/" t)
			 ("melpa" . "http://melpa.milkbox.net/packages/" t)
			 ("melpa-stable" . "http://stable.melpa.org/packages/" t)))

(add-to-list 'package-pinned-packages '(cider . "melpa-stable" t))
(add-to-list 'package-pinned-packages '(magit . "melpa-stable" t))

(package-initialize)

;;; Packages
(defvar my-packages '(;; makes handling lisp expressions easier
		      paredit

		      ;; key bindings and syntax highlighting for clojure
		      clojure-mode

		      ;; extra syntax highlighting for clojure
		      clojure-mode-extra-font-locking

		      ;; integration with clojure repl
		      cider

		      ;; allow ido usage in as many contexts as possible
		      ido-completing-read+

		      ;; M-x enhancement
		      smex

		      ;; project navigation
		      projectile

		      ;; colorful parens matching
		      rainbow-delimiters

		      ;; edit html tags like sexps
		      tagedit

		      ;; git integration
		      magit

		      ;; do rest requests
		      restclient))

;;; Install packages
(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

;;; Add an additional load path that would contain elisp files
(add-to-list 'load-path "~/.emacs.d/vendor")

;;; Customization
(add-to-list 'load-path "~/.emacs/d/customizations")

;;; Load correct environment variables
(load "shell-integration.el")

;;; Easier to navigate files
(load "navigation.el")

;;; UI Tweaks
(load "ui.el")

;;; Editing tweaks
(load "editing.el")

;;; Misc customizations
(load "misc.el")

;;; Editing lisps
(load "elisp-editing.el")

;;; Language-specific
(load "setup-clojure.el")
(load "setup-js.el")

;;; Increase garbage collection threshold to 20M
(setq gs-cons-threshold 2000000)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (restclient magit))))
  
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; 
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1b1918" :foreground "#a8a19f" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 108 :width normal :foundry "1ASC" :family "Ubuntu Mono")))))
