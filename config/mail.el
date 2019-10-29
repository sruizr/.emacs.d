
;; Email configuration
;; Only needed if your maildir is _not_ ~/Maildir
;; Must be a real dir, not a symlink

(setq mu4e-maildir "/home/sruiz/Dropbox/Mail")
(require 'smtpmail)
(require 'mu4e)
(setq mu4e-view-prefer-html t)

(setq mu4e-contexts
    `( ,(make-mu4e-context
          :name "Orange"
          :enter-func (lambda () (mu4e-message "Entrando en contexto Orange"))
          :leave-func (lambda () (mu4e-message "Saliendo de contexto Orange"))
          ;; we match based on the contact-fields of the message
          :match-func (lambda (msg)
                        (when msg
                          (mu4e-message-contact-field-matches msg
                            :to "s.ruiz.r@orange.es")))
          :vars '( ( user-mail-address      . "s.ruiz.r@orange.es"  )
                   ( user-full-name         . "Salvador Ruiz" )
	  	   (mu4e-sent-folder .  "/Orange/Saved Items")
	  	   (mu4e-drafts-folder . "/Orange/Drafts")
	  	   (user-mail-address . "s.ruiz.r@orange.es")
	  	   ;;(smtpmail-stream-type 'starttls)
	  	   (smtpmail-default-smtp-server  . "smtp.orange.es")
	  	   (smtpmail-smtp-user . "s.ruiz.r@orange.es")
	  	   (smtpmail-smtp-server . "smtp.orange.es")
	  	   (smtpmail-smtp-service . 25)
         	   )
					;
	  )
       ,(make-mu4e-context
          :name "Gmail"
          :enter-func (lambda () (mu4e-message "Entrando en Gmail"))
          ;; no leave-func
          ;; we match based on the contact-fields of the message
          :match-func (lambda (msg)
                        (when msg
                          (mu4e-message-contact-field-matches msg
                            :to "salvador.ruiz.r@gmail.com")))
          :vars '( (  user-mail-address       . "salvador.ruiz.r@gmail.com" )
		    (user-full-name          . "Salvador Ruiz" )
	  	  (mu4e-sent-folder . "/Gmail/Saved Items")
	  	   (mu4e-drafts-folder . "/Gmail/Drafts")
	  	   (user-mail-address . "salvador.ruiz.r@gmail.com")
	  	   (smtpmail-default-smtp-server . "smtp.gmail.com")
	  	   (smtpmail-smtp-user . "salvador.ruiz.r@gmail.com")
	  	   (smtpmail-smtp-server . "smtp.gmail.com")
	  	   (smtpmail-smtp-service . 587)
		 )
       )
     )
)

(setq mu4e-context-policy 'pick-first)

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

(global-set-key (kbd "C-<f6>") 'mu4e)
