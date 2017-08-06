; activate all the packages (in particular autoloads)


; assure to install jedi, rope, flake8, importmagic
(use-package elpy
  :ensure t
  :defer 2
  :config
  (progn
    ;; Use Flycheck instead of Flymake
    (when (require 'flycheck nil t)
      (remove-hook 'elpy-modules 'elpy-module-flymake)
      (remove-hook 'elpy-modules 'elpy-module-yasnippet)
      (remove-hook 'elpy-mode-hook 'elpy-module-highlight-indentation)
      (add-hook 'elpy-mode-hook 'flycheck-mode)
      )
    (elpy-enable)
    ;; jedi is great
    (setq elpy-rpc-backend "jedi")
    )
  )
(add-hook 'python-mode-hook 'linum-mode)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  )
(use-package projectile)
(projectile-global-mode)
