(setq org-todo-keywords
      '(
	(sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "SOMEDAY(o)" "|" "CANCELLED(c@/!)")
	)
      )

(setq org-highest-priority 65)
(setq org-lowest-priority 69)
(setq org-default-priority 69)

(print (concat org-base-path "inbox.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (lambda()(concat org-base-path "/inbox.org")) "Inbox")
         "* TODO %?\n :PROPERTIES:\n  :OPEN_ON:%U\n  :END:\n")
	("j" "Journal" entry (file+datetree (lambda() (concat org-base-path "/diary.org")))
	 "**** %U%?%a \n" :tree-type week)
	("m" "Meeting" entry (file+datetree (lambda() (concat org-base-path "/diary.org")))
	 "**** MEETING %U%?%a \n" :tree-type week)
	)
      )

(setq org-agenda-files (list org-base-path))
(setq org-default-notes-file '(concat org-base-path "/inbox.org"))


;; display teh tags farther right
  (setq org-agenda-tags-column -102)

(use-package org-pomodoro)


;; (define-key global-map "\C-cr"
;;   (lambda () (interactive) (org-capture nil "r")))
;; (define-key global-map "\C-cj"
;;   (lambda () (interactive) (org-capture nil "j")))


(defun custom-org-agenda-mode-defaults ()
  (org-defkey org-agenda-mode-map "W" 'oh/agenda-remove-restriction)
  (org-defkey org-agenda-mode-map "N" 'oh/agenda-restrict-to-subtree)
  (org-defkey org-agenda-mode-map "P" 'oh/agenda-restrict-to-project)
  (org-defkey org-agenda-mode-map "q" 'bury-buffer)
  (org-defkey org-agenda-mode-map "I" 'org-pomodoro)
  (org-defkey org-agenda-mode-map "O" 'org-pomodoro)
  (org-defkey org-agenda-mode-map (kbd "C-c C-x C-i") 'org-pomodoro)
  (org-defkey org-agenda-mode-map (kbd "C-c C-x C-o") 'org-pomodoro))

(add-hook 'org-agenda-mode-hook 'custom-org-agenda-mode-defaults 'append)


(require 'org-query-gtd)
(defun rmh/agendablock-tasks-waiting ()
    `(tags-todo "/+WAITING|+DEFERRED"
                ((org-agenda-overriding-header "Tasks waiting for something")
                 (org-tags-match-list-sublevels nil)
                 (org-agenda-skip-function (org-query-select "headline"
(not (org-query-gtd-project))))
                 (org-agenda-todo-ignore-scheduled t)
                 (org-agenda-todo-ignore-deadlines t)
                 )))

(defun rmh/agendablock-next-in-active ()
  `(tags-todo "/+NEXT"
	      ((org-agenda-overriding-header "Next tasks in active projects")
	       (org-agenda-skip-function (
					  org-query-select "headline" (
								       org-query-gtd-active-project-next-task)
							   )
					 )
	       (org-tags-match-list-sublevels 't)
	       (org-agenda-todo-ignore-scheduled 't)
	       (org-agenda-todo-ignore-deadlines 't)
	       (org-agenda-todo-ignore-with-date 't)
	       (org-agenda-sorting-strategy '(priority-down))
	       )
	      )
  )

(defun rmh/agendablock-backlog-of-active ()
    `(tags-todo "/+TODO"
                ((org-agenda-overriding-header "Backlog of active projects")
                 (org-agenda-skip-function (org-query-select "headline" (org-query-gtd-backlog-task)))
                 (org-agenda-todo-ignore-scheduled 't)
                 (org-agenda-todo-ignore-deadlines 't)
                 (org-agenda-todo-ignore-with-date 't)
                 (org-agenda-sorting-strategy
                  '(priority-down )))))

  (defun rmh/agendablock-active-projects-without-next ()
    `(tags-todo "/+NEXT"
                ((org-agenda-overriding-header "Active projects without next task")
                 (org-agenda-skip-function (org-query-select "tree" (org-query-gtd-active-project-stuck)))
                 (org-tags-match-list-sublevels 't)
                 (org-agenda-sorting-strategy
                  '(category-keep)))))

  (defun rmh/agendablock-active-projects-with-next ()
    `(tags-todo "/+NEXT"
                ((org-agenda-overriding-header "Active projects with a next task")
                 (org-agenda-skip-function (org-query-select "tree" (org-query-gtd-active-project-armed)))
                 (org-tags-match-list-sublevels 't)
                 (org-agenda-sorting-strategy
                  '(category-keep)))))

  (defun rmh/agendablock-waiting-projects ()
    `(tags-todo "/+WAITING"
                ((org-agenda-overriding-header "Waiting projects")
                 (org-agenda-skip-function (org-query-select "tree" (org-query-gtd-project)))
                 (org-tags-match-list-sublevels 't)
                 (org-agenda-sorting-strategy
                  '(category-keep)))))

(defun rmh/agendablock-loose-tasks ()
  `(tags-todo "/+TODO"
	      ((org-agenda-overriding-header "Tasks not belonging to a project")
	       (org-agenda-skip-function
		(org-query-select "headline"
				  ;; (and
		  (org-query-gtd-loose-task)
		  ;; (not (org-is-habit-p))
		;;  )
		))
                 ;; (org-agenda-todo-ignore-scheduled 't)
                 ;; (org-agenda-todo-ignore-deadlines 't)
                 ;; (org-agenda-todo-ignore-with-date 't)
                 ;;(org-agenda-sorting-strategy
;; '(category-keep)
	       )))

(defun sr/agendablock-next-role-tasks ()
  `(tags-todo "/+NEXT"
	      ((org-agenda-overriding-header "Next tasks related to role")
	       (org-agenda-skip-function
		(org-query-select "headline"
				  ;; (and
		  (org-query-gtd-loose-task)
		  ;; (not (org-is-habit-p))
		;;  )
		))
                 ;; (org-agenda-todo-ignore-scheduled 't)
                 ;; (org-agenda-todo-ignore-deadlines 't)
                 ;; (org-agenda-todo-ignore-with-date 't)
                 ;;(org-agenda-sorting-strategy
;; '(category-keep)
)))

(defun rmh/agendablock-checklists ()
  `(tags "CHECKLIST"
         ((org-agenda-overriding-header "Checklists")
          (org-tags-match-list-sublevels nil))))

(defun rmh/agendablock-inbox ()
  `(tags-todo "LEVEL=2"
              ((org-agenda-overriding-header "Tasks to refile")
               (org-agenda-skip-function (org-query-select "tree" (org-query-gtd-refile)))
               (org-tags-match-list-sublevels nil))
	      )
  )

(defun sr/to-be-delegated ()
  `(tags-todo "/+TODO"
	      ((org-agenda-overriding-header "Tasks to delegate")
	       (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp  ":2.*:")
		;; (org-query-select "headline"
		;; 					   (org-query-headline
		;; 					    (org-query-stringmatch ":2")))
							   )
	       )
    )
  )

(defun sr/delegated ()
  `(tags-todo "/+WAITING"
	      ((org-agenda-overriding-header "Delegated tasks")
	       (org-agenda-skip-function (org-query-select "headline"
							   (org-query-todo '("WAITING"))
							   ))
	       )
    )
  )
