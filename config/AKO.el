;; Only for working environment
(find-file "/home/sruiz/AKO/Org/gtd.org")
(setq org-default-notes-file "/home/sruiz/AKO/Org/gtd.org")
(setq org-agenda-custom-commands
      '(
	("c" "Simple agenda view"
	 (
	  (todo "NEXT")
	  (tags-todo "+PRIORITY=\"A\"")
	  (tags-todo "+PRIORITY=\"B\"")
	  (agenda "")
	  (alltodo ""
                   ((org-agenda-skip-function
                     '(or (air-org-skip-subtree-if-priority ?A)
                          (org-agenda-skip-if nil '(scheduled deadline))
		       )
		     ))
		   nil
	  )
	 )
	)
	("r" "Reunión"
	 (
	  (todo "TASK")
	  (todo "DELEGATED")
	 )
	 )
       )
)
