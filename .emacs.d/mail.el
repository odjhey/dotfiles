;; I have my "default" parameters from Gmail
(setq mu4e-sent-folder "/sent"
      ;; mu4e-sent-messages-behavior 'delete ;; Unsure how this should be configured
      mu4e-drafts-folder "/drafts"
      user-mail-address "odjhey@gmail.com"
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; Now I set a list of 
(defvar my-mu4e-account-alist
  '(("Gmail"
     (mu4e-sent-folder "/Gmail/sent")
     (user-mail-address "odjhey@gmail.com")
     (smtpmail-smtp-user "odjhey")
     (smtpmail-local-domain "gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587)
     )
    ("FTSI"
     (mu4e-sent-folder "/FTSI/sent")
     (user-mail-address "odee.pacalso@fasttrackph.com")
     (smtpmail-smtp-user "odee.pacalso@fasttrackph.com")
     (smtpmail-local-domain "fasttrackph.com")
     (smtpmail-default-smtp-server "mail.fasttrackph.com")
     (smtpmail-smtp-server "mail.fasttrackph.com")
     (smtpmail-smtp-service 587)
     )
    ;; Include any other accounts here ...
    ))

(defun my-mu4e-set-account ()
  "Set the account for composing a message.
  This function is taken from: 
  https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html"
  (let* ((account
           (if mu4e-compose-parent-message
             (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
               (string-match "/\\(.*?\\)/" maildir)
               (match-string 1 maildir))
             (completing-read (format "Compose with account: (%s) "
                                      (mapconcat #'(lambda (var)  (car var))
                                                 my-mu4e-account-alist "/"))
                              (mapcar #'(lambda (var)  (car var)) my-mu4e-account-alist)
                              nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
      (mapc #'(lambda (var)
                (set (car var)  (cadr var)))
            account-vars)
      (error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

