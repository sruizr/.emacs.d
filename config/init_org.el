;; ORG agenda

(bind-key "C-c l" 'org-store-link)
(bind-key "C-c c" 'org-capture)
(bind-key "C-c a" 'org-agenda)

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)
    )
  )


(setq org-src-fontify-natively t)

;; ORG-BULLETS
(use-package org-bullets
  :init
  (setq org-bullets-bullet-list
	'("◉" "◎" "⚫" "○" "►" "◇"))
  :config
  (setcdr org-bullets-bullet-map nil)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

(setq org-refile-targets '((org-agenda-files :maxlevel . 4)))
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)
(setq org-refile-allow-creating-parent-nodes 'confirm)

;; (find-file "/home/sruiz/Dropbox/Org/inbox.org")n
;; (find-file "/home/sruiz/Dropbox/Org/gtd.org")

;; (setq org-default-notes-file "~/home/sruiz/Dropbox/Org/inbox.org")

(find-file "/home/sruiz/AKO/Org/inbox.org")
(find-file "/home/sruiz/AKO/Org/gtd.org")
(setq org-default-notes-file "/home/sruiz/AKO/Org/gtd.org")

(setq org-agenda-sorting-strategy
 (quote
  (
   (tags priority-down)
   )
   )
 )

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
	  (tags-todo "+TODO=\"NEXT\""
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
	  (tags-todo "+TODO=\"TODO\""
	  	   (
	  	    (org-agenda-overriding-header "Acciones pendientes:")
	  	    (org-agenda-skip-function
	  	     '(org-agenda-skip-if nil '(scheduled deadline))
		    )
	  	   )
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


(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot
