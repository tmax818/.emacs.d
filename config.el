;; increase font size for better readability
(set-face-attribute 'default nil :height 170)

(global-visual-line-mode 1)
(global-display-line-numbers-mode 1)

(global-set-key (kbd "C-x C-b") 'ibuffer) ; instead of buffer-list
(setq ibuffer-expert t) ; stop yes no prompt on delete

 (setq ibuffer-saved-filter-groups
	  (quote (
		  ("default"
		  ("dired" (mode . dired-mode))
		  ("org" (mode . org-mode))
		  ("magit" (name . "^magit"))
		  ("planner" (or
		      (name . "^\\*Calendar\\*$")
		      (name . "^\\*Org Agenda\\*")))
		   ("emacs" (or
		      (name . "^\\*scratch\\*$")
		      (name . "^\\*Messages\\*$")))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

(setq initial-frame-alist '((top . 0) (left . 0) (width . 180) (height . 80)))

(setq make-backup-files nil)
(setq auto-save-default nil)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'material t)

(use-package ivy
  :ensure t)

(use-package which-key
  :ensure t
  :init (which-key-mode))

(use-package vertico
:ensure t
    :init (vertico-mode))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; Read ePub files
(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package swiper
  :ensure t
  :bind ("C-s" . 'swiper))

(use-package mark-multiple
  :ensure t
  :bind ("C-c q" . 'mark-next-like-this))

(use-package dashboard
  :ensure t
  :config
    (dashboard-setup-startup-hook)
    (setq dashboard-startup-banner "~/.emacs.d/img/dashLogo.png")
    (setq dashboard-items '((recents  . 5)
                            (projects . 5)))
    (setq dashboard-banner-logo-title ""))

(use-package projectile
  :ensure t
  :init
    (projectile-mode 1))

(use-package citar
:custom
(citar-bibliography '("~/Dropbox/orgfiles/zettelkasten/bib/references.bib"))
:config
(setq citar-notes-paths '("~/Dropbox/orgfiles/zettelkasten")))

(use-package magit
:ensure t
:config
(setq magit-push-always-verify nil)
(setq git-commit-summary-max-length 50)
:bind
("M-g" . magit-status))

(use-package denote
:ensure t
:config
(progn
  ;; Configure Denote options here
  ;; For example:
  (setq denote-directory "~/Dropbox/orgfiles/zettelkasten")
  (setq denote-file-type 'org)
  (setq denote-prompts '(title keywords)))
  ;; Additional configurations as needed

:hook
(dired-mode . denote-dired-mode)
)

(require 'denote-journal-extras)

(setq org-agenda-files '("~/Dropbox/orgfiles" "~/Dropbox/orgfiles/zettelkasten"))

(defun sluggify (file-name)
  (setq slug (concat (replace-regexp-in-string "[^a-zA-Z0-9-]+" "-" file-name) ".org")
  ))


  (defun generate-new-file-name ()
	  (let* (
		 (file-name (read-string "Title: ")) 
		(my-path (concat "~/Dropbox/orgfiles/zettelkasten/" (replace-regexp-in-string "[^a-zA-Z0-9-]+" "-" file-name) ".org")))

	    (setq org-capture-filename file-name) my-path))

(setq org-capture-templates
	      '(
		("a" "Appt" entry (file+headline "~/Dropbox/orgfiles/index.org" "Appointments")
		 "** APPT %? \nDEADLINE: %^T \n %i\n")

		("s" "Stuff" entry (file+headline "~/Dropbox/orgfiles/index.org" "Capture")
		 "** STUFF %? \n:PROPERTIES:\n:created_at: %u \n:END:\n\n")

		("n" "Note" entry (file (lambda () (generate-new-file-name)))
		 "* %(format org-capture-filename) %^G\n:PROPERTIES:\n:created_at: %u \n:END:\n\n#+biblography: citations.bib\n* backlink:  %a " 
		 )
  )
)

(setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0))

(with-eval-after-load 'org-capture
(add-to-list 'org-capture-templates
             '("n" "New note" plain (file denote-last-path)
               (function (lambda () (denote-org-capture-with-prompts :title :keyword :date (concat denote-directory "/prep/"))))
               :no-save t :immediate-finish nil :kill-buffer t :jump-to-captured t)))
