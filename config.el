;(setq inhibit-startup-message t)

(setq make-backup-files nil)
(setq auto-save-default nil)

(use-package zerodark-theme
  :ensure t
  :init
    (load-theme 'zerodark t)
)

(global-visual-line-mode 1)



(use-package which-key
  :ensure t
  :init (which-key-mode))

(use-package vertico
:ensure t
    :init (vertico-mode))

(use-package mark-multiple
  :ensure t
  :bind ("C-c q" . 'mark-next-like-this))

(global-set-key (kbd "C-x b") 'ibuffer)

;(setq org-agenda-include-diary t)

(setq org-directory "~/Dropbox/orgfiles")
(setq org-agenda-files (list "index.org"))

(setq org-capture-templates
      '(
	("a" "Appt" entry (file+headline "~/Dropbox/orgfiles/index.org" "Appointments")
	 "** APPT %? \nDEADLINE: %^U \n %i\n")

	("s" "Stuff" entry (file+headline "~/Dropbox/orgfiles/index.org" "Stuff")
	 "** STUFF %? \n:PROPERTIES:\n:created_at: %T \n:END:\n\n")
	))

(setq org-todo-keywords
    '((sequence "APPT" "STUFF" "NEXT" "SOMEDAY" "PROJECT" "REFERENCE" "|" "DONE" "CANCELED")))

(setq org-todo-keyword-faces
    '(
      ("APPT" . "red")
      ("STUFF" . "orange")
      ("NEXT" . org-warning)
      ("SOMEDAY" . "yellow")
      ("PROJECT" . "green")
      ("REFERENCE" . "blue")
      ("DONE" . "red")
      ("CANCELED" . (:foreground "blue" :weight bold))
      ))

(setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0))

(setq diary-file "~/Dropbox/diary")
