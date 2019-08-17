;;; Package management
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;;; Packages
(defvar my-packages '(magit
		      restclient))

;;; Install packages
(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

;;; Increase garbage collection threshold to 20M
(setq gs-cons-threshold 2000000)

;;; Show current time
(display-time-mode t)

;;; Hide toolbar
(tool-bar-mode 0)

;;; Shortcuts to change font size
(defun inc-font ()
  (interactive)
  (let ((x (+ (face-attribute 'default :height)
	   10)))
    (set-face-attribute 'default nil :height x)))

(defun dec-font ()
  (interactive)
  (let ((x (- (face-attribute 'default :height)
	      10)))
    (set-face-attribute 'default nil :height x)))

(define-key global-map (kbd "C-1") 'inc-font)
(define-key global-map (kbd "C-0") 'dec-font)

;;; Don't show startup message and splash screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;;; Windmove - switch windows using Shift + arrow keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;; Winner mode - go back to previous window configuration after C-x 1. Use C-c left, C-c right
(when (fboundp 'winner-mode)
  (winner-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (restclient magit))))
  
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1b1918" :foreground "#a8a19f" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 108 :width normal :foundry "1ASC" :family "Ubuntu Mono")))))
