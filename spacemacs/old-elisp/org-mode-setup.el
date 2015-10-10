;; settings for org-mode and remember
(message "org-mode-setup.el")
;; (require 'ox-beamer)
(require 'ox-md)
(require 'ox-html)
;; (require 'ox-taskjuggler)


(setq org-agenda-files (list "~/Dropbox/notes/gtd"
                             "~/Dropbox/notes/blink"
                             "~/Dropbox/notes/ibm"))
(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))
(setq default-major-mode 'org-mode)
(run-at-time "00:59" 3600 'org-save-all-org-buffers)

(setq org-directory "~/Dropbox/notes/")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(add-hook 'org-mode-hook 'turn-on-flyspell 'append)

(setq org-list-allow-alphabetical t)
                                        ; Speed commands
(setq org-use-speed-commands t)
(setq org-speed-commands-user '(("P" . org-property-action)
                                ("z" . org-add-note)
                                ("N" . org-narrow-to-subtree)
                                ("W" . widen)))

(add-hook 'sql-mode-hook
          (lambda ()
            (sql-highlight-db2-keywords)))

;; fontify code in code blocks
(setq org-src-fontify-natively t)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f7>") 'org-todo)
(global-set-key (kbd "S-<f7>") 'org-agenda)
(global-set-key (kbd "<f8>") 'org-capture)
(global-set-key (kbd "S-<f8>") 'org-iswitchb)
;; meta-shift-ret org-insert-todo-heading
(global-set-key (kbd "S-<f6>") 'org-store-link)
(global-set-key (kbd "<f6>") 'org-insert-link)
(global-set-key (kbd "<f12>") 'org-open-at-point)
(global-set-key (kbd "s-<f6>") 'org-toggle-link-display)
(global-set-key (kbd "<f9>") 'outline-previous-visible-heading)
(global-set-key (kbd "<f10>") 'outline-next-visible-heading)

(global-set-key '[(f11)] 'org-time-stamp)


(setq org-remember-templates
      '(
        ("t" "Todo" entry (file+headline "~/Dropbox/notes/gtd/newgtd.org" "Tasks") "* TODO %^{Brief Description} %^g
%?
Added: %U")
        ("l" "Link" entry (file+headline "~/Dropbox/notes/blog/links.org" "Pending Links") "** %^L
  %?
  Added: %u")
        ("b" "Blink Todo" entry (file+headline "~/Dropbox/notes/blink/blinkgtd.org" "Tasks") "* TODO %^{Brief Description} %^g
%?
Added: %U")
        ("n" "Note" entry (file+headline "~/Dropbox/notes/gtd/notes.org" "") "** %^{Head Line} %U %^g
%i%?")
        ("j" "Journal" entry (file+headline "~/Dropbox/notes/gtd/journal.org" "") "** %^{Head Line} %U %^g
%i%?")
        ("c" "Clipboard" entry (file+headline "~/Dropbox/notes/gtd/journal.org" "") "** %^{Head Line} %U %^g
%c
%?")
        ("a" "Daily Review" entry (file+headline "~/Dropbox/notes/gtd/journal.org" "") "** %t :COACH: 
%[~/Dropbox/notes/templates/daily_review]
")
        ("s" "Someday" entry (file+headline "~/Dropbox/notes/gtd/someday.org" "") "** %^{Someday Heading} %U
%?
")
        ("g" "Blog" entry (file+headline "~/Dropbox/notes/gtd/blog.org" "") "** %^{Head Line} %U %^g
%i%?")))


;; (setq org-infojs-options
;;       (quote ((path . "http://orgmode.org/org-info.js")
;;               (view . "showall")
;;               ;; (toc . :table-of-contents)
;;               (toc . t)
;;               (ftoc . "0")
;;               (tdepth . "max")
;;               ;; (sdepth . "max")
;;               (sdepth . "3")
;;               (mouse . "underline")
;;               (buttons . "0")
;;               (ltoc . "1")
;;               (up . :link-up)
;;               (home . :link-home))))



(setq org-structure-template-alist
      (quote (("s" "#+BEGIN_SRC ?\n\n#+END_SRC" "<src lang=\"?\">\n\n</src>")
              ("e" "#+BEGIN_EXAMPLE\n?\n#+END_EXAMPLE" "<example>\n?\n</example>")
              ("q" "#+begin_quote\n?\n#+end_quote" "<quote>\n?\n</quote>")
              ("v" "#+BEGIN_VERSE\n?\n#+END_VERSE" "<verse>\n?\n</verse>")
              ("c" "#+BEGIN_CENTER\n?\n#+END_CENTER" "<center>\n?\n</center>")
              ("l" "#+BEGIN_LaTeX\n?\n#+END_LaTeX" "<literal style=\"latex\">\n?\n</literal>")
              ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
              ("h" "#+begin_html\n?\n#+end_html" "<literal style=\"html\">\n?\n</literal>")
              ("H" "#+html: " "<literal style=\"html\">?</literal>")
              ("a" "#+begin_ascii\n?\n#+end_ascii")
              ("A" "#+ascii: ")
              ("i" "#+index: ?" "#+index: ?")
              ("I" "#+include %file ?" "<include file=%file markup=\"?\">"))))

(define-key org-mode-map (kbd "C-<tab>") nil)
(define-key org-mode-map (kbd "C-S-<tab>") nil)
