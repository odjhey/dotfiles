;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)
(setq package-enable-at-startup nil)

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; mail
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e/")

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(
    ag
    ;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit
    ivy counsel swiper ;; try helm later?
    evil
    evil-surround ;;like tpopes vim surround coool!
    evil-mc ;;multi cursor
    evil-numbers

    auto-complete
    beacon ;; blink blink
    browse-kill-ring
    comment-tags
    exec-path-from-shell
    ;; ledger-mode ;;ledger = command line accounting
    projectile
    markdown-mode
    rainbow-delimiters
    spaceline
    web-mode
    which-key
    ;; benchmark-init ;; profile emacs
    pdf-tools
    ))

;; (dolist (p my-packages)
;;   (when (not (package-installed-p p))
;;     (package-install p)))
(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)


;; (require 'benchmark-init)

;; for some reason this ain't working
(defun load-directory (dir)
  (let ((load-it (lambda (f)
		   (load-file (concat (file-name-as-directory dir) f)))))
    (mapc load-it (directory-files dir nil "\\.el$"))))

(load-directory (concat (file-name-directory user-emacs-directory) "lisp/") )

;;(load-file 
;;  (concat 
;;    (file-name-directory user-emacs-directory)
;;    "lisp/abap-mode.el"))

(load-file 
  (concat 
    (file-name-directory user-emacs-directory)
    "my.el"))



