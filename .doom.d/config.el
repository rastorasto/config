;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Rastislav Uhliar"
      user-mail-address "rastislavuhliar123@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;r numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notes/org/")

(setq org-roam-directory (file-truename "~/notes/roam"))

(setq org-roam-file-extensions '("org"))

(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

(setq org-agenda-span 20)


;; space ff open notes 
(setq default-directory "~/notes/")

(after! org
(setq org-directory "~/notes/")
;;(setq org-agenda-files '("~/notes/roam/" "~/notes/org/"))

;;(setq org-log-done 'time)
;; add keywords for example LECTURE and stuff : )
;;(setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "LECTURE(l)" "GYM(g)" "|" "DONE(d)" "CANCELLED(c)")))

;; recursively goes thrue my folders and finds todos and stuff
(setq org-agenda-files
        (append
         (directory-files-recursively "~/notes/roam/" "\\.org$")
         (directory-files-recursively "~/notes/org/" "\\.org$")))
)

(after! calendar
  ;; 1. Start weeks on Monday (0=Sunday, 1=Monday)
  (setq calendar-week-start-day 1)

  ;; 2. Disable holiday marking entirely
  (setq calendar-mark-holidays-flag nil
        calendar-holidays            nil))

;; (assoc-delete-all "Open project" +doom-dashboard-menu-sections)
;; (assoc-delete-all "Jump to bookmark" +doom-dashboard-menu-sections)
;; (assoc-delete-all "Reload last session" +doom-dashboard-menu-sections)
;; (assoc-delete-all "Recently opened files" +doom-dashboard-menu-sections)
;; (assoc-delete-all "Open documentation" +doom-dashboard-menu-sections)

(setq +doom-dashboard-menu-sections
        (cl-remove-if (lambda (section)
                        (member (car section)
                                '("Open project"
                                  "Jump to bookmark"
                                  "Reload last session"
                                  "Recently opened files"
                                  "Open documentation")))
                      +doom-dashboard-menu-sections))

(defun my/open-school-org ()
  "Open the school.org file."
  (interactive)
  (find-file "~/notes/org/school.org"))

(add-to-list '+doom-dashboard-menu-sections
               '("Open calendar"
                 :icon (nerd-icons-faicon "nf-fa-calendar" :face 'doom-dashboard-menu-title)
                 :action =calendar))

(add-to-list '+doom-dashboard-menu-sections
             '("Open daily  note"
               :icon (nerd-icons-mdicon "nf-md-note" :face 'doom-dashboard-menu-title)
               :action org-roam-dailies-goto-today))

(add-to-list '+doom-dashboard-menu-sections
               '("Open school.org file"
                 :icon (nerd-icons-faicon "nf-fa-school" :face 'doom-dashboard-menu-title)
                 :action my/open-school-org))


(setq org-roam-capture-templates
      '(("m" "main" plain "%?"
         :if-new (file+head "main/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "reference" plain "%?"
         :if-new (file+head "reference/${title}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("a" "article" plain "%?"
         :if-new (file+head "articles/${title}.org"
                            "#+title: ${title}\n#+filetags: :article:\n")
         :immediate-finish t
         :unnarrowed t)
        ("d" "default" plain "%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :unnarrowed t)))

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%d-%m-%Y>.org"
                           "#+title: %<%d-%m-%Y>\n"))))

(use-package org-roam
  :ensure t
  :custom
r (org-roam-directory (file-truename "~/notes/roam/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package! org-roam-ui
  :after org-roam
  :hook (org-roam-mode . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package vterm
  :ensure t
  :commands vterm)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
