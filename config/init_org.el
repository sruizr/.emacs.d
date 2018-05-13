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
      nil)))

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

;; (find-file "/home/sruiz/Dropbox/Org/inbox.org")
;; (find-file "/home/sruiz/Dropbox/Org/gtd.org")

;; (setq org-default-notes-file "~/home/sruiz/Dropbox/Org/inbox.org")
