
; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)
(elpy-enable)

(require 'multiple-cursors)

; load theme
(load-theme 'tango-dark)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (elpy)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Email configuration
;; Only needed if your maildir is _not_ ~/Maildir
;; Must be a real dir, not a symlink

(setq mu4e-maildir "/home/sruiz/Dropbox/Mail")
(require 'smtpmail)
(require 'mu4e)
(setq mu4e-view-prefer-html t)

(setq mu4e-sent-folder "/Orange/Saved Items"
      mu4e-drafts-folder "/Orange/Drafts"
      user-mail-address "s.ruiz.r@orange.es"
      smtpmail-default-smtp-server "smtp.account1.example.com"
      smtpmail-local-domain "account1.example.com"
      smtpmail-smtp-server "smtp.account1.example.com"
;;      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 25)

(defvar my-mu4e-account-alist
  '(
    ("Orange"
     (mu4e-sent-folder "/Orange/Saved Items")
     (mu4e-drafts-folder "/Orange/Drafts")
     (user-mail-address "s.ruiz.r@orange.es")
     ;;(smtpmail-stream-type 'starttls)
     (smtpmail-default-smtp-server "smtp.orange.es")
     (smtpmail-smtp-server "smtp.orange.es")
     (smtpmail-smtp-service 25)
    )
    ("Gmail"
     (mu4e-sent-folder "/Gmail/Saved Items")
     (mu4e-drafts-folder "/Gmail/Drafts")
     (user-mail-address "salvador.ruiz.r@gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-user "salvador.ruiz.r@gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587))
    )
  )

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
(add-to-list 'mu4e-view-actions
	     '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq shr-color-visible-luminance-min 80)
(setq mu4e-update-interval 300)
(setq mu4e-msg2pdf "/usr/bin/msg2pdf")
(setq mu4e-get-mail-command "getmail -r orange -r gmail"
      mu4e-update-interval 300)
(add-hook 'mu4e-view-mode-hook
  (lambda()
    ;; try to emulate some of the eww key-bindings
    (local-set-key (kbd "<tab>") 'shr-next-link)
    (local-set-key (kbd "<backtab>") 'shr-previous-link)))

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))



;; Key bindings for multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-<f6>") 'mu4e)
(global-set-key [(M-<Up>)]  'move-line-up)
(global-set-key [(M-<Down>)]  'move-line-down)


(find-file "/home/sruiz/Dropbox/Org/inbox.org")
(find-file "/home/sruiz/Dropbox/Org/gtd.org")
(delete-selection-mode 1)
