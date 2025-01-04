
;; global line numbers
(global-display-line-numbers-mode 1)

;; global visual line mode
(visual-line-mode)



;; Color Themes
;; Read http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/
;; for a great explanation of emacs color themes.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Custom-Themes.html
;; for a more technical explanation.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night-bright t)

;; increase font size for better readability
(set-face-attribute 'default nil :height 150)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
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
