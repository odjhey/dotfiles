;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(setq package-enable-at-startup nil)
(package-initialize)

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

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit
    ;; colorful parenthesis matching
    rainbow-delimiters
    ;; try helm later?
    ivy
    ;; emulate vi here
    evil
    ;; sane org mode on evil
    org-evil
    ;; evil collection
    ;; evil-collection
    spaceline
    ;;
    beacon
    ;;
    browse-kill-ring
    ;;
    evil-surround ;;like tpopes vim surround coool!
    auto-complete
    comment-tags
    evil-magit
    which-key
    ;; profile emacs
    benchmark-init
    ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(require 'benchmark-init)

(load-file 
  (concat 
    (file-name-directory user-emacs-directory)
    "my.el"))



