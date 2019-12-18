;; (setq org-agenda-files (list "~/AKO/org/tasks.org"
;;                              "~/.org/tasks.org_archive"
;;                              "~/.org/projects.org"
;;                              "~/.org/projects.org_archive"
;;                              "~/.org/job.org"
;;                              "~/.org/job.org_archive"
;;                              "~/.org/calendar.org"))

(setq org-base-path "~/AKO/Org")
(load "~/.emacs.d/config/gtd-mode.el")

(setq org-tag-persistent-alist
     '(
	(:startgroup . nil)
	  ("2jVillaubi" . ?v)
	  ("2jSantos" . ?s)
	  ("2aSerra" . ?a)
	  ("2saLopez" . ?l)
	  ("2aRilo" . ?r)
	  ("2jlLucena" . ?j)
	(:endgroup . nil)
	(:startgroup . nil)
	  ("_Rápida" . ?r)
	  ("_Zombi" . ?z)
	  ("_Roca" . ?R)
	(:endgroup . nil)
	))

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
