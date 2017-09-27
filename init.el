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


 (defhydra hydra-window ()
   "
Movement^^        ^Split^         ^Switch^		^Resize^
----------------------------------------------------------------
_h_ ←       	_v_ertical    	_b_uffer		_q_ X←
_j_ ↓        	_x_ horizontal	_f_ind files	_w_ X↓
_k_ ↑        	_z_ undo      	_a_ce 1		_e_ X↑
_l_ →        	_Z_ reset      	_s_wap		_r_ X→
_F_ollow		_D_lt Other   	_S_ave		max_i_mize
_SPC_ cancel	_o_nly this   	_d_elete	
"
   ("h" windmove-left )
   ("j" windmove-down )
   ("k" windmove-up )
   ("l" windmove-right )
   ("q" hydra-move-splitter-left/body)
   ("w" hydra-move-splitter-down/body)
   ("e" hydra-move-splitter-up/body)
   ("r" hydra-move-splitter-right/body)
   ("b" helm-mini)
   ("f" helm-find-files)
   ("F" follow-mode)
   ("a" (lambda ()
          (interactive)
          (ace-window 1)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body))
       )
   ("v" (lambda ()
          (interactive)
          (split-window-right)
          (windmove-right))
       )
   ("x" (lambda ()
          (interactive)
          (split-window-below)
          (windmove-down))
       )
   ("s" (lambda ()
          (interactive)
          (ace-window 4)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body)))
   ("S" save-buffer)
   ("d" delete-window)
   ("D" (lambda ()
          (interactive)
          (ace-window 16)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body))
       )
   ("o" delete-other-windows)
   ("i" ace-maximize-window)
   ("z" (progn
          (winner-undo)
          (setq this-command 'winner-undo))
   )
   ("Z" winner-redo)
   ("SPC" nil)
   )
(global-set-key (kbd "C-x w") 'hydra-window/body)

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

(use-package multiple-cursors
  :ensure t
  )
(defhydra multiple-cursors-hydra (:hint nil)
  
  "
     ^Up^            ^Down^        ^Other^
----------------------------------------------
[_p_]   Next    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all
[_M-p_] Unmark  [_M-n_] Unmark  [_r_] Mark by regexp
^ ^             ^ ^             [_q_] Quit
"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-nevious-like-this)
  ("P" mc/skip-to-nevious-like-this)
  ("M-p" mc/unmark-nevious-like-this)
  ("r" mc/mark-all-in-region :exit t)
  ("q" nil)
  ("<mouse-1>" mc/add-cursor-on-click)
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore)
)
(global-set-key (kbd "C-<") 'multiple-cursors-hydra/body)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  )

					; load theme

;; Click [here](https://github.com/hbin/dotfiles-for-emacs) to take a further look.
;; Run on terminal (curl -L https://github.com/hbin/top-programming-fonts/raw/master/install.sh | bash) to
;; install fonts Menlo, Monaco, ....
(set-frame-font "Menlo:pixelsize=18")

;; If you use Emacs Daemon mode
(add-to-list 'default-frame-alist
               (cons 'font "Menlo:pixelsize=18"))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#eaeaea" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#424242"))
 '(custom-safe-themes
   (quote
    ("cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "52588047a0fe3727e3cd8a90e76d7f078c9bd62c0b246324e557dfa5112e0d0c" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "f8cf128fa0ef7e61b5546d12bb8ea1584c80ac313db38867b6e774d1d38c73db" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(fci-rule-color "#424242")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(package-hidden-regexps (quote ("helm-projectile")))
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow helm-projectile hydra magit use-package transpose-frame projectile org-bullets hydra elpy dash)))
 '(send-mail-function (quote smtpmail-send-it))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil))
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
(add-hook 'python-mode 'linum-mode)
;(global hl-line-mode)

;; Key bindings for multiple cursors
;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key [(M-<Up>)]  'move-line-up)
(global-set-key [(M-<Down>)]  'move-line-down)


;  (use-package powerline
;    )
;(powerline-default-theme)

(use-package spaceline
  :demand t
  :init
  (setq powerline-default-separator 'arrow-fade)
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme)
  )
  
