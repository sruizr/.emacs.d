;; activate all the packages (in particular autoloads)
(use-package smartparens
  :ensure ;
  :diminish smartparens-mode
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode)
  )
(use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
    )
(use-package yaml-mode
  :ensure t
  :mode "\\.yaml\\'"
  )

  (use-package web-mode
    :ensure t
    :mode ("\\.html\\'")
    :config
    (progn
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (setq web-mode-enable-current-element-highlight t)
      (setq web-mode-ac-sources-alist
	    '(("css" . (ac-source-css-property))
	      ("html" . (ac-source-words-in-buffer ac-source-abbrev)))
	    )
      (set
       (make-local-variable 'company-backends)
       '(company-css company-web-html company-yasnippet company-files)
       )
      )
    )
(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;;
  )

(use-package company
    :ensure t
    :diminish
    :config
    (add-hook 'after-init-hook 'global-company-mode)

    (setq company-idle-delay t)
    )

;; assure to install jedi, rope, flake8, importmagic
(use-package elpy
  :ensure t
  :defer 2
  :config
  (progn
    ;; Use Flycheck instead of Flymake
    (when (require 'flycheck nil t)
      (remove-hook 'elpy-modules 'elpy-module-flymake)
;;      (remove-hook 'elpy-modules 'elpy-module-yasnippet)
;;      (remove-hook 'elpy-mode-hook 'elpy-module-highlight-indentation)
      (add-hook 'elpy-mode-hook 'flycheck-mode)
      )
    (elpy-enable)
    ;; jedi is great
    (setq elpy-rpc-backend "jedi")
    (setq elpy-rpc-python-command "python3")

    )
  :bind (
	 ("C-c C-n" . next-error)
	 ("C-c C-p" . previous-error)
	 )
  )

(add-hook 'python-mode-hook
	  'linum-mode
	  'elpy-mode
	  (add-hook 'before-save-hook 'delete-trailing-whitespace)
	  )
(add-hook 'before-save-hook 'delete-trailing-whitespace)


(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))

  )

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
  )
(projectile-global-mode)

(use-package helm-projectile
      :ensure    helm-projectile
      :init
      (helm-projectile-on)
      :config
      (progn
        (setq projectile-switch-project-action 'projectile-dired)
        (setq projectile-completion-system 'helm)
	)
      )
(use-package flycheck
  :ensure t
  )

(use-package yasnippet
  :ensure t
  :init (add-hook 'prog-mode-hook #'yas-minor-mode)
  :config
  (progn
    (yas-reload-all)
    (setq yas-installed-snippets-dir "~/.emacs.d/snippets")
    )
  )
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
