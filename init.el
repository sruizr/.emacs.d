;; Maximize when buffer is selected
(package-initialize)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (add-hook 'window-setup-hook 'toggle-frame-maximized t))

;; Creating Emacs lisp files
(add-to-list 'load-path "~/.emacs.d/elisp/")

(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;; (setq custom-file "~/.emacs.d/custom.el")
;; (load custom-file)


;; Using use-package from now
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-verbose t)

(require 'use-package)

(load "~/.emacs.d/config/init_org.el")
(load "~/.emacs.d/config/init_mail.el")
(load "~/.emacs.d/config/init_coding.el")

;; SETTING LOCALE UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; HYDRA
(use-package hydra
  :defer t
  )

(defhydra hydra-vc ()
  "vc hydra"
  ("n" git-gutter+-next-hunk  "next hunk")
  ("p" git-gutter+-previous-hunk "previous hunk")
  ("d" git-gutter+-show-hunk "show diff")
  ("r" git-gutter+-revert-hunk "revert hunk")
  ("b" magit-blame "blame")
  ("a" vc-annotate "annotate")
  ("t" git-timemachine "timemachine" :exit t)
  )

(global-set-key (kbd "<f8>") 'hydra-vc/body)

(use-package transpose-frame)

(defhydra hydra-transpose ()
  "transposing hydra"
  ("l" transpose-lines "lines")
  ("w" transpose-words "words")
  ("s" transpose-sexps "sexps")
  ("p" transpose-paragraphs "paragraphs")
  ("c" transpose-chars "characters")
  ("W" transpose-frame "windows")
  )

(global-set-key (kbd "C-x C-t") 'hydra-transpose/body)

(defun insert-date (arg)
   (interactive "P")
   (insert (if arg
               (format-time-string "%d.%m.%Y")
             (format-time-string "%Y-%m-%d"))))

(global-set-key (kbd "C-t") 'insert-date)

(defhydra hydra-modes ()
  "settings hydra"
  ("l" lisp-interaction-mode "lisp interaction" :exit t)
  ("p" python-mode "python" :exit t)
  ("o" org-mode "org" :exit t)
  ("x" sx-compose-mode "Stack Exhange compose" :exit t)
  ("s" sql-mysql "MySQL interaction" :exit t)
  ("m" gfm-mode "Markdown" :exit t)
  ("j" js2-mode "JavaScript" :exit t)
  ("w" web-mode "Web" :exit t)
  )

(global-set-key (kbd "s-M") 'hydra-modes/body)

(use-package multiple-cursors)
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
)

; load theme
(load-theme 'tango-dark)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (hydra magit use-package transpose-frame projectile org-bullets multiple-cursors hydra elpy dash)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))


(delete-selection-mode 1)


;; Key bindings for multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key [(M-<Up>)]  'move-line-up)
(global-set-key [(M-<Down>)]  'move-line-down)
