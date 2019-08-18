;; These customizations make it easier to navigate files,
;; switch buffers, and choose options from the minibuffer.

;; "When several buffers visit identically-named files,
;; Emacs must give the buffers distinct names. 
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Turn on recent file mode so that you can more easily switch to
;; recently edited files when you first start emacs
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)

;; projectile everywhere!
(projectile-global-mode)

;;; Windmove - switch windows using Shift + arrow keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;; Winner mode - go back to previous window configuration after C-x 1. Use C-c left, C-c right
(when (fboundp 'winner-mode)
  (winner-mode 1))
