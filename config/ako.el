;; (setq org-agenda-files (list "~/AKO/org/tasks.org"
;;                              "~/.org/tasks.org_archive"
;;                              "~/.org/projects.org"
;;                              "~/.org/projects.org_archive"
;;                              "~/.org/job.org"
;;                              "~/.org/job.org_archive"
;;                              "~/.org/calendar.org"))

(setq org-todo-keywords
      '(
	  (sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
	  (sequence "WAITING(w@/!)" "HOLD(h@/!)" "SOMEDAY(o)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
	  (sequence "TASK(f)"  "GAVE(l!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
	)
      )

(setq org-highest-priority 65)
(setq org-lowest-priority 69)
(setq org-default-priority 67)


(setq org-tag-persistent-alist
     '(
	(:startgroup . nil)
	  ("2jVillaubi" . ?v)
	  ("2jSantos" . ?s)
	  ("2aSerra" . ?a)
	  ("2saLopez" . ?l)
	(:endgroup . nil)
	(:startgroup . nil)
	  ("_Rápida" . ?r)
	  ("_Zombi" . ?z)
	  ("_Roca" . ?R)
	(:endgroup . nil)
	))


(setq org-agenda-files '("~/AKO/Org"))

(find-file "/home/sruiz/AKO/Org/inbox.org")
(setq org-default-notes-file "/home/sruiz/AKO/Org/inbox.org")

(setq org-agenda-custom-commands
      '(
	("c" "Simple agenda view"
	 (
	  (tags-todo "+TODO=\"NEXT\""
		     (
		      (org-agenda-overriding-header "Próximas acciones:")
		      (org-agenda-skip-function
		       '(org-agenda-skip-entry-if 'notregexp "\[#[A-E]\]")
		      )
		      )
		     )
	  (agenda "")
	  ;; (tags-todo "+PRIORITY=\"A\"")
	  ;; (tags-todo "+PRIORITY=\"B\"")
	  ;; (tags-todo "+PRIORITY=\"C\"" )
	  ;; (tags-todo "+PRIORITY<=\"D\"")
	  (alltodo ""
	  	   (
	  	    (org-agenda-overriding-header "Acciones sin planificar:")
	  	    (org-agenda-skip-function
	  	     '(or
	  		 (org-agenda-skip-entry-if 'regexp "\[#[A-E]\]")
	  		 (org-agenda-skip-if nil '(scheduled deadline))
	  		 )
		     )
		    )
	  	   )
	  )
	 )
	("r" "Reunión"
	 (
	  (todo "TASK")
	  (todo "GAVE")
	  )
	 )
	)

      )
