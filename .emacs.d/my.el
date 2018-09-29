(require 'spaceline-config)
(spaceline-spacemacs-theme)

(evil-mode 1)
(load-theme 'spacemacs-dark)

(ivy-mode 1)
(beacon-mode 1)

(rainbow-delimiters-mode 1)
(rainbow-mode)

;;Gargabe Collection
;;Allow 20MB of memory (instead of 0.76MB) before calling garbage collection. This means GC runs less often, which speeds up some operations.
(setq gc-cons-threshold 20000000)

;;Do not create backup files
(setq make-backup-files nil)

;;Auto-Save in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;When opening a file, always follow symlinks.
(setq vc-follow-symlinks t)

;;Sentences have one space after a period
;;Don’t assume that sentences should have two spaces after periods.
(setq sentence-end-double-space nil)

;; y/n over yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; auto refresh buffer when changed outside
(global-auto-revert-mode t)

;; Shortcut for changing font-size
(define-key global-map (kbd "C-1") 'text-scale-increase)
(define-key global-map (kbd "C-0") 'text-scale-decrease)

;;Do not display GUI Toolbar
(tool-bar-mode 0)


;; todo (hide all bars)

;;Remember the cursor position of files when reopening them
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

(require 'browse-kill-ring)
(setq browse-kill-ring-highlight-inserted-item t
      browse-kill-ring-highlight-current-entry nil
      browse-kill-ring-show-preview t)
(define-key browse-kill-ring-mode-map (kbd "j") 'browse-kill-ring-forward)
(define-key browse-kill-ring-mode-map (kbd "k") 'browse-kill-ring-previous)


(require 'evil-surround)
(global-evil-surround-mode 1)


;; Multiple Cursors
;; https://github.com/gabesoft/evil-mc
;; evil-mc provides multiple cursors functionality for Emacs when used with evil-mode.
;; C-n / C-p are used for creating cursors, and M-n / M-p are used for
;; cycling through cursors. The commands that create cursors wrap
;; around; but, the ones that cycle them do not. To skip creating a
;; cursor forward use C-t or grn and backward grp. Finally use gru to
;; remove all cursors.
;;Enable evil-mc for all buffers
;;(global-evil-mc-mode  1)

;;Increment / Decrement numbers
(global-set-key (kbd "C-=") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C--") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "C-=") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C--") 'evil-numbers/dec-at-pt)

;;Use j/k for browsing wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;;Unbind M-. and M- in evil-mode (goto def, back)
(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-normal-state-map (kbd "M-,") nil)

;;Which Key
;;which-key displays available keybindings in a popup.
(add-hook 'org-mode-hook 'which-key-mode)
(add-hook 'cider-mode-hook 'which-key-mode)

;;Highlight matching parenthesis
(show-paren-mode t)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
