;; Frame
(add-to-list 'default-frame-alist
			 '(ns-transparent-titlebar . t))
;;(add-to-list 'default-frame-alist
;;         '(ns-appearance . dark)) ;; or dark - depending on your theme
(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;;; Macos' ls is not supported
;;(when (string= system-type "darwin")
;;  (setq dired-use-ls-dired nil))
(setq x-select-enable-clipboard nil)

;; base?
(setq delete-old-versions -1 )          ; delete excess backup versions silently
(setq version-control t )               ; use version control
(setq vc-make-backup-files t )          ; make backups file even when in version controlled dir
(setq vc-follow-symlinks t )            ; don't ask for confirmation when opening symlinked file
(setq inhibit-startup-screen t )        ; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )      ; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )   ; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
;; (setq sentence-end-double-space nil) ; sentence SHOULD end with only a point. *How bout md?*
(setq default-fill-column 80)           ; toggle wrapping text at the 80th character
(setq initial-scratch-message ";; *SCRATCH*")       ; print a default message in the empty scratch buffer opened at startup

;; (setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
;; (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq backup-directory-alist ;;Auto-Save in /tmp
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; UI
;;Do not display GUI Toolbar
;;(tool-bar-mode 0)
;;(menu-bar-mode -1)
;;(toggle-scroll-bar -1)
;;(display-time-mode t)

(menu-bar-mode 0)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq mouse-highlight nil)
(setq column-number-mode t)
(setq-default cursor-in-non-selected-windows nil)
(setq x-underline-at-descent-line t)
(setq x-stretch-cursor t)
(setq frame-resize-pixelwise t)
(setq uniquify-buffer-name-style 'forward)
(show-paren-mode)


;;(require 'cl)
;;(require 'powerline)
(add-to-list 'default-frame-alist '(font . "SourceCodePro+Powerline+Awesome Regular 16" ))
(set-face-attribute 'default t :font "SourceCodePro+Powerline+Awesome Regular 16" )
;; (set-frame-font "SourceCodePro+Powerline+Awesome Regular 14" nil t)

(require 'spaceline-config)
(spaceline-spacemacs-theme)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
(setq powerline-default-separator 'slant)
(setq display-time-default-load-average nil)
(spaceline-compile)

(load-theme 'spacemacs-dark)
(setq evil-emacs-state-cursor '("white" (bar . 4)))
;;c-z to escape to shell
;;https://stackoverflow.com/questions/26666608/bind-c-z-in-evil-mode-to-escape-to-shell
(setq evil-toggle-key ""); remove default evil-toggle-key C-z, manually setup later
(setq evil-toggle-key "C-x C-z")

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "t" 'counsel-find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "<RET>" 'evil-switch-to-windows-last-buffer
  "<SPC>" 'Control-X-prefix
  "s" 'swiper
  "a" 'org-agenda
  "v" 'er/expand-region
  "m" 'org-ctrl-c-ctrl-c
  )

;; evil-nerd-commenter
;; evil-snipe
;; evil-lion ; alignments

(evil-mode 1)

(with-eval-after-load 'evil-maps
  (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
  (define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
  (define-key evil-normal-state-map (kbd "gd") 'xref-find-definitions)
  )

;; (evil-set-command-property 'xref-find-definitions :jump t)


;; require evil-args?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IVY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
(setq enable-recursive-minibuffers t)
;;(global-set-key "\C-s" 'swiper)
;;(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;(global-set-key (kbd "<f1> f") 'counsel-describe-function)
;;(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;;(global-set-key (kbd "<f1> l") 'counsel-find-library)
;;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;;(global-set-key (kbd "C-c g") 'counsel-git)
;;(global-set-key (kbd "C-c j") 'counsel-git-grep)
;;(global-set-key (kbd "C-c k") 'counsel-ag)
;;(global-set-key (kbd "C-x l") 'counsel-locate)
;;(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; (beacon-mode 1)
;; (setq beacon-size 20)

(global-aggressive-indent-mode)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
(add-to-list 'aggressive-indent-excluded-modes 'sql-mode)
(add-to-list 'aggressive-indent-excluded-modes 'web-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG MODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-c\C-l" 'org-insert-link)
(define-key global-map "\C-c\C-o" 'org-open-at-point)
(define-key global-map "\C-c\C-x\C-n" 'org-next-link)
(define-key global-map "\C-c\C-x\C-p" 'org-previous-link)
(setq org-return-follows-link t)
(setq org-export-coding-system 'utf-8)

;; ORG BABEL
;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . t)
   (shell . t)))

;; Org protocol
(require 'org-protocol)

;; Org capture
(load-file
 (concat
  (file-name-directory user-emacs-directory)
  "orgcapture.el"))

;;;; deafult file to open
;;(find-file "~/org/my.org")


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
(define-key global-map (kbd "s--") 'text-scale-decrease)

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
(setq savehist-additional-variables        ;; Also save ...
  '(search-ring regexp-search-ring)        ;; ... searches
  savehist-file "~/.emacs.d/savehist") ;; keep home clean
(savehist-mode t)              ;; do this before evaluation
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
    search-ring
    regexp-search-ring))
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
(setq evil-mc-one-cursor-show-mode-line-text t)

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
;; (add-hook 'cider-mode-hook 'which-key-mode) ; enable when using cider
(which-key-setup-minibuffer)


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
		(newline-mark ?\n    [?¬ ?\n]  [?$ ?\n])    ; eol - negation
		(tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
		))

;;Highlight the latest changes in the buffer (like text inserted from:
;;yank, undo, etc.) until the next command is run. Nice, since it lets
;;me see exactly what was changed.
(when (require 'volatile-highlights nil 'noerror)
  (volatile-highlights-mode t))

;; undo tree
(setq undo-tree-visualizer-timestamps t)
(setq undo-tree-visualizer-diff t)

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

;; projectile
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

;; server
;; (server-start) ;; use a daemon

;; company
(global-company-mode)
(setq company-idle-delay 0.2)
(setq company-selection-wrap-around t)
(define-key company-active-map [tab] 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(setq company-tooltip-align-annotations t)
(setq company-minimum-prefix-length 2)


;; hide some minor modes
(require 'diminish)
(diminish 'jiggle-mode)
(diminish 'ivy-mode)
(diminish 'which-key-mode)
(diminish 'evil-mc-mode)
(diminish 'volatile-highlights-mode)
(diminish 'undo-tree-mode)
(diminish 'projectile-mode)
(diminish 'eldoc-mode)
(diminish 'beacon-mode)
(diminish 'company-mode)
(diminish 'text-scale-mode)
(diminish 'rainbow-mode)
(diminish 'aggressive-indent-mode)
;; Replace abbrev-mode lighter with "Abv"
;; (diminish 'abbrev-mode "Abv")

(require 'mu4e)
(require 'org-mu4e)
(require 'evil-mu4e)
(setq mu4e-mu-binary "/usr/local/bin/mu")
;;store link to message if in header view, not to header query
(setq org-mu4e-link-query-in-headers-mode nil)
;; Don't ask to quit... why is this the default?
(setq mu4e-confirm-quit nil)

;; Include a bookmark to open all of my inboxes
(add-to-list 'mu4e-bookmarks
             (make-mu4e-bookmark
              :name "All Inboxes"
              :query "maildir:/odee.ftsi/INBOX OR maildir:/odjhey@gmail.com/INBOX"
              :key ?i))

(setq tab-width 4)
