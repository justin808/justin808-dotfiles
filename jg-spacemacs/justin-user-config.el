(setq load-path
      (append
       (list
        (expand-file-name "~/dotfiles/justin808-dotfiles/jg-spacemacs")
        (expand-file-name "~/forks/org-octopress")
        )
       load-path))

(setq mac-option-modifier 'meta)
(setq mac-right-option-modifier 'meta)
(setq mac-command-modifier 'super)

(load "jg-methods")
(load "jg-util-funcs")
(load "dired-setup")
(load "register")

(column-number-mode t)
(display-time-mode t)


;; Indentation from
;; http://blog.binchen.org/posts/easy-indentation-setup-in-emacs-for-web-development.html
(defun my-setup-indent (n)
  ;; web development
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
  )

(my-setup-indent 2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable some commands disabled by default
;; (put 'set-goal-column  'disabled nil)
;; (put 'upcase-region    'disabled nil)
;; (put 'narrow-to-region 'disabled nil)
;; (put 'downcase-region  'disabled nil)
;; (put 'eval-expression 'disabled nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq font-use-system-font t)
;(setq completion-ignore-case t )
;; (setq text-mode-hook
;;       '(lambda ()
;;          (auto-fill-mode 1)
;;          (setq indent-line-function 'indent-relative-maybe)
;;          (setq sentence-end-double-space nil)
;;          (setq fill-individual-varying-indent nil)
;;          (local-set-key "\C-m" 'newline-and-indent)
;;          ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ---------
;; PROCESSES
;; ---------
;; (setq completion-ignored-extensions '(".o" ".elc" "~" ".bin" ".bak"
;;                                       ".obj" ".map" ".dvi" ".toc"
;;                                       ".aux" ".a" ".ln" ".lof" ".blg" ".bbl"
;;                                       ".glo" ".idx" ".lot" ".fmt"
;;                                       ".class" ".flc" ".java.flc"))
(setq shell-completion-fignore '("~" "#" "%" ".class" ))
;; (setq shell-dirstack-query "dirs")
                                        ;(setenv "ESHELL" (expand-file-name "~/Dropbox/bin/eshell"))
(setenv "ESHELL" (expand-file-name "/bin/bash"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defun my-lisp-mode-hook ()
;;   (message "my-lisp-mode-hook")
;;   ;; offset customizations not in my-c-style
;;   (local-set-key "\C-m" 'newline-and-indent)
;;   (local-set-key "\C-c\C-c" 'comment-region)
;;   )

;; (add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
;; (add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)

(setq auto-mode-alist
      (append
       '(("\\.java$" . java-mode)
         ("\\.jsp$"  . java-mode)
         ("\\.C$"  . c++-mode)
         ("\\.coffee$" . coffee-mode)
         ("\\.cpp$" . c++-mode)
         ("\\.H$"  . c++-mode)
         ("\\.cc$" . c++-mode)
         ("\\.hh$" . c++-mode)
         ("\\.c$"  . c-mode)
         ("\\.h$"  . c++-mode)
         ("\\.m$"  . objc-mode)
         ("\\.gnus$"  . emacs-lisp-mode)
         ("\\.vm$"  . emacs-lisp-mode)
         ("\\.sh$"  . sh-mode)
         ("\\.sql$"  . sql-mode)
         ("\\.table$"  . fundamental-mode)
         ("\\.jar$"  . archive-mode)
         ("\\.ear$"  . archive-mode)
         ("\\.js$"  . js-mode)
         ("\\.org\\'" . org-mode)
         ("BUGS$"  . text-mode)
         ("\\.aliases$" . shell-script-mode)
         ("\\.functions$" . shell-script-mode)
         ("\\.austinrc$" . shell-script-mode)
         ("\\.zsh$" . shell-script-mode)
         ("\\.script$"  . java-mode)
         ("\\.rb$" . ruby-mode)
         ("Rakefile$" . ruby-mode)
         ("\\.rake$" . ruby-mode)
         ("Gemfile$" . ruby-mode)
         ("\\.gemspec$" . ruby-mode)
         ("\\.md" . markdown-mode)
         ("README\\.md" . gfm-mode)
         ("\\.scpt" . apples-mode)
         ("\\.applescript" . apples-mode)
         ("\\.jsx" . jsx-mode)
         ("\\.scss" . sass-mode)
         ("\\.tpl" . handlebars-mode)
         ("\\.jsx" . javascript-mode)
         ) auto-mode-alist))

;; (autoload 'jsx-mode "jsx-mode" "JSX mode" t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MARKDOWN
;; (add-hook 'markdown-mode-hook (lambda () (visual-line-mode t)))

(defun markdown-preview-file-marked ()
  "run Marked on the current file and revert the buffer"
  (interactive)
  (save-buffer)
  (shell-command
   (format "open -a /Applications/Marked.app %s"
           (shell-quote-argument (buffer-file-name))))
  )
(global-set-key "\C-cm" 'markdown-preview-file-marked)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'my-down
      "\C-u12\C-n")
(fset 'my-up
      "\C-u12\C-p")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(message "2")

;; ============
;; KEY BINDINGS
;; ============


(global-set-key [f2] 'magit-status)
(global-set-key (kbd "C-x m") 'magit-status)

;; (global-set-key (kbd "s-<f2>") (lambda () (interactive) (ediff-revision (buffer-file-name (current-buffer)))))
;; (global-set-key '[(control N)] 'my-down) ;; move up and down by 15 lines per stroke
;; (global-set-key '[(control P)] 'my-up)

(global-set-key (kbd "M-S-SPC") 'my-just-one-space)
(global-set-key (kbd "C-!") 'my-just-one-space)
(global-set-key (kbd "C-s-SPC") 'my-just-one-space)

(global-set-key [?\C-\M- ] 'my-jump-mark-ring)
(global-set-key "\C-xf" 'find-file-at-point)
(global-set-key "\C-h\C-f" 'find-function-at-point)


;; This is similar to JetBrains last-edit-location
;; Also mapped to g ;
(global-set-key (kbd "<S-s-backspace>") 'goto-last-change)
(global-set-key (kbd "<C-s-backspace>") 'goto-last-change)

;; mac cmd keys to be like RubyMine
(global-set-key (kbd "s-0") 'delete-other-windows)
(global-set-key (kbd "s-1") 'neotree-toggle)
(global-set-key (kbd "s-r") 'query-replace)
(global-set-key (kbd "s-S-r") 'query-replace-regexp)

;; set preferred key bindings
(global-set-key '[(shift f3)]                'rename-uniquely)

;(global-set-key '[(meta N)]                  'comint-next-matching-input-from-input) ;; retrieve next matching command
; (global-set-key '[(meta P)]                  'comint-previous-matching-input-from-input) ;; retrieve previous matching command
; (global-set-key '[(control +)]               'balance-windows)
;; (global-set-key '[(meta left)]               'my-unbury-buffer)
;; (global-set-key '[(meta right)]              'my-bury-buffer)
;; (global-set-key '[(control meta tab)]        'repeat-complex-command)
;; (global-set-key '[(control \;)]              'delete-indentation) ;; delete indentaion - join lines
;; (global-set-key '[(control :)]               'reversedeleteindentation) ;; delete indentaion - join lines backwards

;; YANKING, KILLING, INSERTING, OTHER TEXT STUFF
(global-set-key `[(control >)] 'slide-in)
(global-set-key `[(control <)] 'slide-out)

;; FRAME AND WINDOW SETTINGS
;; (global-set-key '[(meta control \:)] 'my-other-frame-back)
;; (global-set-key '[(meta control \;)] 'other-frame)
;; (global-set-key '[(alt \:)] 'my-other-frame-back)
;; (global-set-key '[(alt \;)] 'other-frame)

(global-set-key "\C-xt" 'my-toggle-line-wrap)
(global-set-key "\C-xc" 'my-toggle-case-fold-search)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; LISP WORK
;; LISPM bindings of Control-Shift-C and Control-Shift-E.
;; Note that "\C-C" means Control-C, not Control-Shift-C.
;; To specify shifted control characters, you must use the
;; more verbose syntax used here.
;; (define-key emacs-lisp-mode-map '[(control C)] 'compile-defun)
;; (define-key emacs-lisp-mode-map '[(control E)] 'eval-defun)


;; MISC ENTRIES
(define-key global-map '[(control tab)] 'other-window)
(define-key global-map '[(shift control tab)] 'my-other-window-back)
(global-set-key '[(control tab)] 'other-window)
(global-set-key '[(shift control tab)] 'my-other-window-back)

;; next is emacs specific
(global-set-key		"\C-x\C-m"	'my-return-key-toggle)
(global-set-key		"\C-h\C-a"	'apropos-variable)

(global-set-key		'[(f5)]	'my-revert-buffer)
(global-set-key	(kbd "s-<f5>") 'my-revert-all-buffers)

(global-set-key '[(meta /)]            'hippie-expand)
(global-set-key '[(meta return)]            'dabbrev-expand)

(global-set-key '[(control meta up)]               'shrink-window)
(global-set-key '[(control meta down)]               'enlarge-window)
(global-set-key '[(control meta left)]               'shrink-window-horizontally)
(global-set-key '[(control meta right)]               'enlarge-window-horizontally)

(global-set-key [(f6)] 'repeat)
(global-set-key [(control meta f12)] 'call-last-kbd-macro)


(add-hook 'after-init-hook
          '(lambda ()
             (setq require-final-newline nil)))

(setq-default require-final-newline nil)

(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key [(mouse-6)] 'scroll-right)
(global-set-key [(mouse-7)] 'scroll-left)
(global-set-key '[(control return)]     'browse-url-of-dired-file)
(global-set-key [(control meta f12)] 'call-last-kbd-macro)

(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key [(mouse-6)] 'scroll-right)
(global-set-key [(mouse-7)] 'scroll-left)

(global-set-key (kbd "C-=") 'jg-indent-region)
(global-set-key (kbd "C-+") 'jg-unindent-region)

;; (setq abbrev-file-name             ;; tell emacs where to read abbrev
;;       "~/dotfiles/private-dotfiles/spacemacs/abbrev_defs.el")    ;; definitions from...
;; (setq save-abbrevs t)              ;; save abbrevs when files are saved
;; you will be asked before the abbreviations are saved
;; (quietly-read-abbrev-file)       ;; reads the abbreviations file on startup

(dolist (hook '(org-mode-hook
                text-mode-hook))
  (add-hook hook (lambda () (abbrev-mode 1))))

(load "org-mode-setup")
(load "my-keys-minor-mode-map")
;;(load "tramp-setup")
;; (load "slime-setup")
;;(load "org-octopress-setup")
;;(load "org-octo-jg-publish")

(global-set-key (kbd "<s-wheel-down>") 'text-scale-decrease)
(global-set-key (kbd "<s-wheel-up>") 'text-scale-increase)

(global-set-key (kbd "C-M-]") (lambda () (interactive) (org-cycle t)))
(global-set-key (kbd "M-]") (lambda ()
                              (interactive)
                              (ignore-errors
                                (end-of-defun)
                                (beginning-of-defun))
                              (org-cycle)))


;; commit in magit opens new emacs
;; http://stackoverflow.com/questions/18856047/emacs-magit-commit-opens-new-emacs-client
;;(set-variable 'magit-emacsclient-executable "/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9/emacsclient")
;; (set-variable 'magit-emacsclient-executable "/usr/local/bin/emacsclient")

;; http://superuser.com/questions/695761/emacs-right-click-context-menu-on-mac-os/695797?iemail=1&noredirect=1#695797
(global-set-key [mouse-3] 'mouse-buffer-menu)

(add-hook 'markdown-mode-hook 'turn-on-pandoc)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

;; FIX crazy adding of everything selected to the clipboard.
(fset 'evil-visual-update-x-selection 'ignore)
