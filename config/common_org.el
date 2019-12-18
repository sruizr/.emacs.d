;; ORG agenda
(require 'org)
(bind-key "C-c l" 'org-store-link)
(bind-key "C-c c" 'org-capture)
(bind-key "C-c a" 'org-agenda)
(bind-key  (kbd "<M-return>") 'org-meta-return)
(bind-key (kbd "<M-enter>") 'org-meta-return)


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

(add-to-list 'org-modules 'org-habit t)
(setq org-habit-preceding-days 7
      org-habit-following-days 1
      org-habit-graph-column 80
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today t)

(setq org-src-fontify-nativey t)

;; Replace ** cascade to bullets!
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

(setq org-agenda-sorting-strategy
 (quote
  (
   (tags priority-down)
   )
   )
 )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot
