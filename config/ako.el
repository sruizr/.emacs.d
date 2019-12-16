;; (setq org-agenda-files (list "~/AKO/org/tasks.org"
;;                              "~/.org/tasks.org_archive"
;;                              "~/.org/projects.org"
;;                              "~/.org/projects.org_archive"
;;                              "~/.org/job.org"
;;                              "~/.org/job.org_archive"
;;                              "~/.org/calendar.org"))

(setq org-base-path "~/AKO/Org")

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


;; (setq org-agenda-custom-commands
;;       '(
;; 	("c" "Simple agenda view"
;; 	 (
;; 	  (tags-todo "+TODO=\"NEXT\""
;; 		     (
;; 		      (org-agenda-overriding-header "Próximas acciones:")
;; 		      (org-agenda-skip-function
;; 		       '(org-agenda-skip-entry-if 'notregexp "\[#[A-E]\]")
;; 		      )
;; 		      )
;; 		     )
;; 	  (agenda "")
;; 	  ;; (tags-todo "+PRIORITY=\"A\"")
;; 	  ;; (tags-todo "+PRIORITY=\"B\"")
;; 	  ;; (tags-todo "+PRIORITY=\"C\"" )
;; 	  ;; (tags-todo "+PRIORITY<=\"D\"")
;; 	  (alltodo ""
;; 	  	   (
;; 	  	    (org-agenda-overriding-header "Acciones sin planificar:")
;; 	  	    (org-agenda-skip-function
;; 	  	     '(or
;; 	  		 (org-agenda-skip-entry-if 'regexp "\[#[A-E]\]")
;; 	  		 (org-agenda-skip-if nil '(scheduled deadline))
;; 	  		 )
;; 		     )
;; 		    )
;; 	  	   )
;; 	  )
;; 	 )
;; 	("r" "Reunión"
;; 	 (
;; 	  (todo "TASK")
;; 	  (todo "GAVE")
;; 	  )
;; 	 )
;; 	)
;;       )
