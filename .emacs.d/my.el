;; shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(setq exec-path-from-shell-debug t)

;;(require 'cl)
;;(require 'powerline)
(add-to-list 'default-frame-alist '(font . "SourceCodePro+Powerline+Awesome Regular 16" ))
(set-face-attribute 'default t :font "SourceCodePro+Powerline+Awesome Regular 16" )
;; (set-frame-font "SourceCodePro+Powerline+Awesome Regular 14" nil t)

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

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "t" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "<RET>" 'evil-switch-to-windows-last-buffer
  "<SPC>" 'Control-X-prefix
  "s" 'swiper
  "a" 'org-agenda
  )
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
(setq enable-recursive-minibuffers t)
;;(global-set-key "\C-s" 'swiper)
;;(global-set-key (kbd "C-c C-r") 'ivy-resume)
;;(global-set-key (kbd "<f6>") 'ivy-resume)
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

(beacon-mode 1)
(setq beacon-size 20)

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

;; Org protocol
(require 'org-protocol)

;; Org capture
(setq org-default-notes-file "~/org/unfiled.org")
;; Org capture templates
(setq org-capture-templates
      '(("t" ; hotkey
	 "Todo list item" ; name
	 entry ; type
	 ; heading type and title
	 (file+headline org-default-notes-file "Tasks")
	 "* TODO %?\n %i\n %a" ;template
	 )
	("j" "Journal Entry"
	 entry (file+datetree "~/org/journal.org")
	 (file "~/.emacs.d/org-templates/journal.orgcaptmpl"))
;;	("b" "Tidbit: quote, zinger, one-liner or textlet"
;;	 entry
;;	 (file+headline org-default-notes-file "Tidbits")
;;	 (file "~/.emacs.d/org-templates/tidbit.orgcaptmpl"))	
;;	("l" "A link, for reading later."
;;	 entry (file+headline org-default-notes-file "Reading List")
;;         "* the sf" ;; "* %:description\n%u\n\n%c\n\n%i"
;;	 )
;;	("L" "Protocol Link" entry (file+headline org-default-notes-file "Inbox")
;;	 "* %? [[%:link][%:description]] %(progn (setq kk/delete-frame-after-capture 2) \"\")\nCaptured On: %U"
;;	 :empty-lines 1)
	))


;;;; another attempt at closing capture frame
;; (defvar kk/delete-frame-after-capture 0 "Whether to delete the last frame after the current capture")
;; (defun kk/delete-frame-if-neccessary (&rest r)
;;   (cond
;;    ((= kk/delete-frame-after-capture 0) nil)
;;    ((> kk/delete-frame-after-capture 1)
;;     (setq kk/delete-frame-after-capture (- kk/delete-frame-after-capture 1)))
;;    (t
;;     (setq kk/delete-frame-after-capture 0)
;;     (delete-frame))))
;; (advice-add 'org-capture-finalize :after 'kk/delete-frame-if-neccessary)
;; (advice-add 'org-capture-kill :after 'kk/delete-frame-if-neccessary)
;; (advice-add 'org-capture-refile :after 'kk/delete-frame-if-neccessary)

;;;; closing capture frame called by external
;;(defun make-capture-frame ()
;;  "Create a new frame and run org-capture."
;;  (interactive)
;;  (make-frame '((name . "capture")))
;;  (select-frame-by-name "capture")
;;  (delete-other-windows)
;;  (org-capture)
;;  )
;;
;;(defadvice org-capture-finalize (after delete-capture-frame activate)
;;  "Advise capture-finalize to close the frame if it is the capture frame"
;;  (if (equal "capture" (frame-parameter nil 'name))
;;      (delete-frame)))

;;(defadvice org-capture
;;    (after make-full-window-frame activate)
;;  "Advise capture to be the only window when used as a popup"
;;  (if (equal "emacs-capture" (frame-parameter nil 'name))
;;      (delete-other-windows)))
;;
;;(defadvice org-capture-finalize
;;    (after delete-capture-frame activate)
;;  "Advise capture-finalize to close the frame"
;;  (if (equal "emacs-capture" (frame-parameter nil 'name))
;;      (delete-frame (selected-frame) t)))


;; org capture madness!!
(defadvice org-capture
    (after make-full-window-frame activate)
  "Advise capture to be the only window when used as a popup"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-other-windows)))

(defadvice org-capture-finalize
(after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (when (and (equal "capture" (frame-parameter nil 'name))
	 (not (eq this-command 'org-capture-refile)))
(delete-frame)))

(defadvice org-capture-refile
(after delete-capture-frame activate)
  "Advise org-refile to close the frame"
  (delete-frame))

(defun activate-capture-frame ()
  "run org-capture in capture frame"
  (select-frame-by-name "capture")
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (org-capture)) 

;;Do not display GUI Toolbar
(tool-bar-mode 0)
(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(display-time-mode t)
;; no start screen
(setq inhibit-startup-screen t)

;;;; deafult file to open
;;(find-file "~/org/my.org") 

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
(setq savehist-additional-variables    ;; Also save ...
  '(search-ring regexp-search-ring)    ;; ... searches
  savehist-file "~/.emacs.d/savehist") ;; keep home clean
(savehist-mode t)                      ;; do this before evaluation
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
(which-key-setup-minibuffer)

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

