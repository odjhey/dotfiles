;; shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;(require 'cl)
;;(require 'powerline)
(set-frame-font "SourceCodePro+Powerline+Awesome Regular 14" nil t)

(require 'spaceline-config)
(spaceline-spacemacs-theme)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
(setq powerline-default-separator 'slant)
(spaceline-compile)

(load-theme 'spacemacs-dark)
(setq evil-emacs-state-cursor '("white" (bar . 4)))
;;c-z to escape to shell
;;https://stackoverflow.com/questions/26666608/bind-c-z-in-evil-mode-to-escape-to-shell
(setq evil-toggle-key ""); remove default evil-toggle-key C-z, manually setup later
(setq evil-toggle-key "C-x C-z")
(evil-mode 1)

(with-eval-after-load 'evil-maps
  (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
  (define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line))

(ivy-mode 1)
(beacon-mode 1)

;;Do not display GUI Toolbar
(tool-bar-mode 0)
(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(display-time-mode t)

(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist
             '(ns-appearance . dark)) ;; or dark - depending on your theme

;; nav windows and splits using c-<arrow key>
;; mostly used in <E> mode. 
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;Gargabe Collection
;;Allow 20MB of memory (instead of 0.76MB) before calling garbage
;;collection. This means GC runs less often, which speeds up some
;;operations.
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

;;Enable Narrow To Region
(put 'narrow-to-region 'disabled nil)
;;Nice auto complete
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;; y/n over yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; auto refresh buffer when changed outside
(global-auto-revert-mode t)

;; Shortcut for changing font-size
(define-key global-map (kbd "s-=") 'text-scale-increase)
(define-key global-map (kbd "s-0") 'text-scale-decrease)

;; window spliting
(define-key global-map (kbd "s-1") 'delete-other-windows)
(define-key global-map (kbd "s-2") 'split-window-below)
(define-key global-map (kbd "s-3") 'split-window-right)
(define-key global-map (kbd "s-4") 'clone-indirect-buffer-other-window)
(define-key global-map (kbd "s-5") 'transpose-frame)

;;Remember the cursor position of files when reopening them
(setq save-place-file "~/.emacs.d/saveplace")
;;(setq-default save-place t)
(save-place-mode 1)
(require 'saveplace)

;;Save History--------------------------------
;;Save mode-line history between sessions. Very good!
(setq savehist-additional-variables    ;; Also save ...
  '(search-ring regexp-search-ring)    ;; ... searches
  savehist-file "~/.emacs.d/savehist") ;; keep home clean
(savehist-mode t)                      ;; do this before evaluation
;;--------------------------------------------

(require 'browse-kill-ring)
(setq browse-kill-ring-highlight-inserted-item t
      browse-kill-ring-highlight-current-entry nil
      browse-kill-ring-show-preview t)
(define-key browse-kill-ring-mode-map (kbd "j") 'browse-kill-ring-forward)
(define-key browse-kill-ring-mode-map (kbd "k") 'browse-kill-ring-previous)

(require 'evil-surround)
(global-evil-surround-mode 1)
;; multi cursor
(global-evil-mc-mode  1)

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

;; look for bindings
;;Increment / Decrement numbers
(global-set-key (kbd "C-=") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C--") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "C-=") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C--") 'evil-numbers/dec-at-pt)

;;Use j/k for browsing wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;;im used to gd
;;;;Unbind M-. and M- in evil-mode (goto def, back)
;;(define-key evil-normal-state-map (kbd "M-.") nil)
;;(define-key evil-normal-state-map (kbd "M-,") nil)

;;Which Key
;;which-key displays available keybindings in a popup.
(add-hook 'org-mode-hook 'which-key-mode)
(add-hook 'cider-mode-hook 'which-key-mode)

;;Highlight matching parenthesis
(show-paren-mode t)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

(rainbow-mode 1)
(rainbow-delimiters-mode 1)

;; syntax highlights
(add-to-list 'auto-mode-alist '("\\.abap\\'" . abap-mode))


(setq whitespace-display-mappings
  ;; all numbers are Unicode codepoint in decimal. ⁖ (insert-char 182 1)
  '(
    (space-mark 32 [183] [46]) ; 32 SPACE 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
    ;;(newline-mark 10 [182 10]) ; 10 LINE FEED
    (newline-mark ?\n    [?¬ ?\n]  [?$ ?\n])	; eol - negation
    (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
    ))

;;Highlight the latest changes in the buffer (like text inserted from:
;;yank, undo, etc.) until the next command is run. Nice, since it lets
;;me see exactly what was changed. 
(when (require 'volatile-highlights nil 'noerror)
  (volatile-highlights-mode t))

;;Search all open buffers---------------------
(defun search (regexp)
  "Search all buffers for a regexp."
  (interactive "sRegexp to search for: ")
  (multi-occur-in-matching-buffers ".*" regexp))
;;--------------------------------------------

;;nuke-all-buffers-----------------------------
(defun nuke-all-buffers ()
"Kill all buffers, leaving *scratch* only."
(interactive)
(mapc (lambda (x) (kill-buffer x)) (buffer-list)) (delete-other-windows))
;;---------------------------------------------

;;Kill all other buffers----------------------
;;kills all buffers, except the current one.
(defun kill-all-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))
;;--------------------------------------------

;;(require 'unicode-fonts)
;;(unicode-fonts-setup)
;;(set-language-environment "UTF-8")
;;(set-default-coding-systems 'utf-8)
;;(set-clipboard-coding-system 'utf-16le)


