;; Ajuste de TODO y TAGS
;; Definición de etiquetas que uso a efectos de organización y recodatorio

;; Mis estados de tareas
;; Uso 2, el primero a efectos de planificación y el segundo para acción

(setq org-todo-keywords '((sequence "HACER:(t)" "|" "HECHO:(d)")))

;; Establece los colores para los estados

(setq org-todo-keyword-faces
      '(("HACER:" . (:foreground "Red" :weight bold))
	("HECHO:" . (:foreground "Green" :weight bold))
	))

;; Mi lista de etiquetas
;; La primera el Área de Atención
;; La segunda el contexto según GTD
;; La tercera tiempo/energía

(setq org-tag-persistent-alist
     '(
	(:startgroup . nil)
	  ("#Personal" . ?p)
	  ("#Doméstico" . ?d)
	  ("#Social" . ?s)
	  ("#Redes_Sociales" . ?S)
	(:endgroup . nil)
	(:startgroup . nil)
	  ("@Casa" . ?c)
	  ("@Ordenador" . ?o)
	  ("@Recado" . ?r)
	  ("@Teléfono" . ?t)
	  ("@Tablet" . ?T)
	(:endgroup . nil)
	(:startgroup . nil)
	  ("_Rápida" . ?r)
	  ("_Zombi" . ?z)
	  ("_Roca" . ?R)
	(:endgroup . nil)
	))

;; Ajusta el color de las etiquetas

(setq org-tag-faces
      '(
	("#Personal" . (:foreground "Green"))
	("#Doméstico" . (:foreground "Green"))
	("#Social" . (:foreground "Green"))
	("#Redes_Sociales" . (:foreground "Green"))
	("@Casa" . (:foreground "Blue"))
	("@Ordenador" . (:foreground "Blue"))
	("@Recado" . (:foreground "Blue"))
	("@Teléfono" . (:foreground "Blue"))
	("@Tablet" . (:foreground "Blue"))
	("_Rápida" . (:foreground "Yellow"))
	("_Zombi" . (:foreground "Yellow"))
	("_Roca" . (:foreground "Yellow"))
       ))

;; Ajuste de org-capture


(setq org-reverse-note-order t)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)
;; (bind-key "C-c l" 'org-store-link)
