;; loading mu4e environment
(load "~/.emacs.d/config/mail.el")

;; Opening the main org working files
(find-file "~/Dropbox/Documents/Org/gtd.org")

;;Org file distribution
(setq org-agenda-files (list "~/Dropbox/Documents/Org/tasks.org"
                             "~/Dropbox/Documents/Org/tasks.org_archive"
                             "~/Dropbox/Documents/Org/projects.org"
                             "~/Dropbox/Documents/Org/projects.org_archive"
                             "~/Dropbox/Documents/Org/calendar.org"))

(setq org-capture-templates
      '(
	("r" "Todo" entry (file+headline "~/Dropbox/Documents/Org/inbox.org" "Inbox")
         "* TODO %?")
	("j" "Journal" entry (file+datetree "~/Dropbox/Documents/Org/journal.org")
	 "**** %U%?%a \n" :tree-type week)
	)
      )
