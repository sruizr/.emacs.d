;; activate all the packages (in particular autoloads)


; assure to install jedi, rope, flake8, importmagic
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
    )
  )
(add-hook 'python-mode-hook
	  'linum-mode
	  (add-hook 'before-save-hook 'delete-trailing-whitespace)
	  )
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  )


(use-package projectile
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
(use-package kivy-mode
  :ensure t
  :mode "\\.kv\\'"
  )
