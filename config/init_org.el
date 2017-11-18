;; ORG agenda

(bind-key "C-c l" 'org-store-link)
(bind-key "C-c c" 'org-capture)
(bind-key "C-c a" 'org-agenda)


;; ORG-BULLETS
(use-package org-bullets
:init
(setq org-bullets-bullet-list
'("◉" "◎" "⚫" "○" "►" "◇"))
:config
(setcdr org-bullets-bullet-map nil)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

(find-file "/home/sruiz/Dropbox/Org/inbox.org")
(find-file "/home/sruiz/Dropbox/Org/gtd.org")

(setq org-default-notes-file "~/home/sruiz/Dropbox/Org/inbox.org")
