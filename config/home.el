;; loading mu4e environment
;; (load "~/.emacs.d/config/mail.el")
(require 'org)
(load "~/.emacs.d/config/mail.el")

(setq org-base-path "~/Dropbox/Documents/Org")
(load "~/.emacs.d/config/gtd-mode.el")

(setq org-agenda-custom-commands
        `(
	  (" " "Agenda"
	   ((agenda "" ((org-agenda-span 3)))
	    ,(rmh/agendablock-inbox)
           ;; ,(rmh/agendablock-tasks-waiting)
	    ,(rmh/agendablock-next-in-active)
	    ,(sr/agendablock-next-role-tasks)
           ;; ,(rmh/agendablock-active-projects-with-next)
           ;; ,(rmh/agendablock-active-projects-without-next)
           ;; ,(rmh/agendablock-waiting-projects)
	    ,(rmh/agendablock-backlog-of-active)
	    ,(rmh/agendablock-checklists))
	   nil)
          ("r" "Review Agenda"
           ((agenda "" ((org-agenda-span 3)))
            ,(rmh/agendablock-inbox)
            ,(rmh/agendablock-loose-tasks)
            ,(rmh/agendablock-tasks-waiting)
            ,(rmh/agendablock-next-in-active)
            ,(rmh/agendablock-active-projects-with-next)
            ,(rmh/agendablock-active-projects-without-next)
            ,(rmh/agendablock-backlog-of-active)
            ,(rmh/agendablock-checklists))
           nil)
	  ("b" "Blockers"
	   ((agenda "" ((org-agenda-span 3)))
	    ,(sr/to-be-delegated)
	    ,(sr/delegated)
	    )
	   )
	  )
	)
