(setq org-todo-keywords
      '(
	(sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "SOMEDAY(o)" "|" "CANCELLED(c@/!)")
	(sequence "TASK(f)"  "DELEGATED(l!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
	)
      )

(use-package org-journal)

(use-package org-habit
  :config
  ;; display the org-habit graph right of the tags
  (setq org-habit-graph-column 102)
  (setq org-habit-following-days 7)
  (setq org-habit-preceding-days 21)
  )

;; display teh tags farther right
  (setq org-agenda-tags-column -102)

(use-package org-pomodoro)

(setq org-capture-templates
      '(("r" "Todo" entry (file+headline "~/.org/inbox.org" "Inbox")
         "* TODO %?")
        ("j" "Journal" entry (file+datetree "~/.org/journal.org")
         (file "~/.org/templates/review"))
	)
      )


(define-key global-map "\C-cr"
  (lambda () (interactive) (org-capture nil "r")))
(define-key global-map "\C-cj"
  (lambda () (interactive) (org-capture nil "j")))


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
