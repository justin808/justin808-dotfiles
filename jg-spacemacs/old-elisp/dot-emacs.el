(message "dot-emacs.el")
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;;(when
;;    (load
;;     (expand-file-name "~/.emacs.d/elpa/package.el"))
;;  (package-initialize))

(desktop-save-mode 1)

;; This needs to be set before loading evil.el

(setq evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t
      evil-shift-width 2)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; http://melpa.milkbox.net/
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(setq package-user-dir "~/Dropbox/linux/config/elpa")
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(setq package-user-dir "~/.emacs.d/elpa")

(package-initialize)


(setq load-path
      (append
       (list
        (expand-file-name "~/Dropbox/linux/config/lisp_vendor")
        (expand-file-name "~/forks/org-octopress")
        (expand-file-name "~/forks/org-mode/lisp")
        (expand-file-name "~/forks/org-mode/contrib/lisp")
        )
       load-path))


;; (unless (package-installed-p 'org)  ;; Make sure the Org package is
;; (package-install 'org))           ;; installed, install it if not

(require 'org)

(load "jg-methods")

(require 'undo-tree)
(global-undo-tree-mode)

;;(require 'sr-speedbar)
(setq speedbar-show-unknown-files t)

;;(require 'textmate)
;; note, this tries to map ctrl-tab!
;;(textmate-mode)
;;(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)


(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(defun force-backup-of-buffer ()
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)
;; This caused problems by creating unnecessary diffs
;;(add-hook 'before-save-hook 'whitespace-cleanup)

(load "jg-util-funcs")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar jg-tab-width 2)
(setq fill-column 80)
(setq-default fill-column 80)
(setq-default tab-width jg-tab-width)
(setq js-indent-level 2)
(setq javascript-indent-level 2)
(setq jsx-indent-level 2)
(setq-default tab-stop-list ( list 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 104 112 120))
(setq-default indent-tabs-mode nil)
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows t)
(setq transient-mark-mode 't  )
(setq visible-bell t)
(setq case-fold-search t)
(setq suggest-key-bindings t)
(setq inhibit-startup-message t)
(setq kill-ring-max 60)
(setq mark-ring-max 60)

(setq mouse-drag-copy-region nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-javascript-mode-hook () (setq indent-tabs-mode t tab-width 2 js-indent-level 2)) (add-hook 'javascript-mode-hook 'my-javascript-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; enable some commands disabled by default
(put 'set-goal-column  'disabled nil)
(put 'upcase-region    'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region  'disabled nil)
(put 'eval-expression 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(delete-selection-mode)
(transient-mark-mode)

;;(partial-completion-mode t)
;;(setq completion-styles ‘(partial-completion initials))
(setq completion-pcm-complete-word-inserts-delimiters t)
;; this is different in gnu emacs than XEmacs
(toggle-scroll-bar -1)
(setq scroll-bar-mode nil)
(setq apropos-do-all t)
(setq highlight-nonselected-windows nil)

(load "dired-setup")
;;(load "sunrise-setup")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(column-number-mode t)
(display-time-mode t)
(show-paren-mode t)
(tool-bar-mode -1)


(setq font-use-system-font t)
(setq dabbrev-case-replace t)
(setq dabbrev-abbrev-char-regexp "\\sw\\|\\s_")
(setq dabbrev-case-fold-search nil)

(setq completion-ignore-case t )

(setq-default tab-width jg-tab-width
              indent-tabs-mode nil
              )
                                        ;(pending-delete-mode t)
(mouse-avoidance-mode 'jump)

(setq text-mode-hook
      '(lambda ()
         (auto-fill-mode 1)
         (setq indent-line-function 'indent-relative-maybe)
         ;;(setq filladapt-mode t)
         (setq sentence-end-double-space nil)
         (setq fill-individual-varying-indent nil)
         (local-set-key "\C-m" 'newline-and-indent)
         ))

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
(add-hook 'sql-mode-hook 'turn-on-font-lock)

;; JAVA STUFF
(message "Configuring CC")
(defun my-c-mode-common-hook ()
  (setq c-echo-syntactic-information-p nil)
  (setq c-tab-always-indent t
        tab-width jg-tab-width
        indent-tabs-mode nil
        c-basic-offset tab-width
        case-fold-search t
        )
  (c-toggle-hungry-state 1)
  (define-key c-mode-map "\C-m" 'newline-and-indent)
  (local-set-key "\C-cc" 'comment-region)
  ;;(c-set-offset 'substatement-open 0)
  ;;(c-set-offset 'label 0)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


(defun my-java-mode-hook ()
  (message "my-java-mode-hook")
  ;; offset customizations not in my-c-style
  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key "\C-cc" 'comment-region)
  (local-set-key "{" 'my-insert-braces)

  (modify-syntax-entry ?\_ "w");; make _ a regular "in-word" char
  ;;(c-add-style "JG Java Formatting Style" jg-java-style t)
  ;;  (c-set-style 'java)
  (c-set-offset 'member-init-intro '+)
  (c-set-offset 'topmost-intro-cont '+)
  (c-set-offset 'inclass '+)
  (c-set-offset 'func-decl-cont '+)
  (c-set-offset 'substatement-open '0)
  (c-set-offset 'substatement '0)

  ;; from tariq
  (setq indent-tabs-mode nil)
  ;;(c-set-offset 'inline-open 0)
  )
(add-hook 'java-mode-hook 'my-java-mode-hook)



(defun my-cpp-mode-hook ()
  "makes _ a word char, sets Meta-Tab"
  (interactive)
  (message "my-cpp-mode-hook")
  (setq-default abbrev-mode t)
  (modify-syntax-entry ?\_ "w");; make _ a regular "in-word" char
  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key "\C-cc" 'comment-region)
  (local-set-key "\M-q" 'indent-region) ;; disable fill paragraph which is sloooow
  ;;  (fume-add-menubar-entry)
  )
(add-hook 'c++-mode-hook 'my-cpp-mode-hook)

(load "cc-mode")


(defun my-lisp-mode-hook ()
  (message "my-lisp-mode-hook")
  ;; offset customizations not in my-c-style
  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key "\C-c\C-c" 'comment-region)
  )

(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)
(message "1")
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
         ) auto-mode-alist))

(autoload 'jsx-mode "jsx-mode" "JSX mode" t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MARKDOWN

(add-hook 'markdown-mode-hook (lambda () (visual-line-mode t)))


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
(global-set-key (kbd "s-<f2>") (lambda () (interactive) (ediff-revision (buffer-file-name (current-buffer)))))
(global-set-key '[(control N)] 'my-down) ;; move up and down by 15 lines per stroke
(global-set-key '[(control P)] 'my-up)

(global-set-key (kbd "M-S-SPC") 'my-just-one-space)
(global-set-key (kbd "C-!") 'my-just-one-space)
(global-set-key (kbd "C-s-SPC") 'my-just-one-space)

(global-set-key [?\C-\M- ] 'my-jump-mark-ring)
(global-set-key "\C-xf" 'find-file-at-point)
(global-set-key "\C-h\C-f" 'find-function-at-point)



;; This is similar to JetBrains last-edit-location
(require 'goto-last-change)
(global-set-key (kbd "<S-s-backspace>") 'goto-last-change)
(global-set-key (kbd "<C-s-backspace>") 'goto-last-change)

;; mac cmd keys to be like RubyMine
(global-set-key (kbd "s-0") 'delete-other-windows)
(global-set-key (kbd "s-1") 'speedbar-get-focus)
(global-set-key (kbd "s-r") 'query-replace)
(global-set-key (kbd "s-S-r") 'query-replace-regexp)


;; Emacs grabs f14 so need to remap to do the Mac OS thing
(global-set-key (kbd "<f14>") 'other-frame)
(global-set-key (kbd "S-<f14>") (lambda () (interactive) (other-frame -1)))

;; unset previously boubd keys to reset them
(global-unset-key '[(control z)])

;; set preferred key bindings
(global-set-key (kbd "C-x m")                'magit-status)
(global-set-key '[(shift f3)]                'rename-uniquely)

;; next one confliced with evil
;;(global-set-key '[(meta g)]                  'goto-line)
(global-set-key '[(meta N)]                  'comint-next-matching-input-from-input) ;; retrieve next matching command
(global-set-key '[(meta P)]                  'comint-previous-matching-input-from-input) ;; retrieve previous matching command
(global-set-key '[(control +)]               'balance-windows)
;; (global-set-key '[(meta left)]               'my-unbury-buffer)
;; (global-set-key '[(meta right)]              'my-bury-buffer)
;; (global-set-key '[(control meta tab)]        'repeat-complex-command)
;; (global-set-key '[(control \;)]              'delete-indentation) ;; delete indentaion - join lines
;; (global-set-key '[(control :)]               'reversedeleteindentation) ;; delete indentaion - join lines backwards

(global-set-key '[(control meta l)] 'switch-to-other-buffer)

;; YANKING, KILLING, INSERTING, OTHER TEXT STUFF
(global-set-key [(control K)] 'my-kill-line-back)
(global-set-key "\C-z" 'undo-tree-undo)
(global-set-key `[(control >)] 'slide-in) ; was slide-in, but had a bug
(global-set-key `[(control <)] 'slide-out)


;; SEARCH AND REPLACE
;; (global-set-key "\M-r" 'query-replace)
;;(global-set-key '[(alt r)] 'query-replace-regexp)

;; RECTANGLE
(global-set-key "\C-xrc" 'my-copy-rectangle)
(global-set-key "\C-xrC" 'clear-rectangle) ; by default on "\C-xrc"


;; FRAME AND WINDOW SETTINGS
(global-set-key '[(meta control \:)] 'my-other-frame-back)
(global-set-key '[(meta control \;)] 'other-frame)
(global-set-key '[(alt \:)] 'my-other-frame-back)
(global-set-key '[(alt \;)] 'other-frame)
(global-set-key "\C-xt" 'my-toggle-line-wrap)
(global-set-key "\C-xc" 'my-toggle-case-fold-search)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; next binding messes up terminals!!!
                                        ;(global-set-key "\M-[" 'my-match-paren)

;; CURSOR MOVEMENT
(global-set-key "\C-x," 'beginning-of-buffer)
(global-set-key "\C-x." 'end-of-buffer)

;; LISP WORK
;; LISPM bindings of Control-Shift-C and Control-Shift-E.
;; Note that "\C-C" means Control-C, not Control-Shift-C.
;; To specify shifted control characters, you must use the
;; more verbose syntax used here.
(define-key emacs-lisp-mode-map '[(control C)] 'compile-defun)
(define-key emacs-lisp-mode-map '[(control E)] 'eval-defun)


;; MISC ENTRIES
;;(define-key global-map '[(shift tab)] 'self-insert-command) ;; for programming to avoid auto indentations
(define-key global-map '[(control tab)] 'other-window)
(define-key global-map '[(shift control tab)] 'my-other-window-back)
(global-set-key '[(control tab)] 'other-window)
(global-set-key '[(shift control tab)] 'my-other-window-back)

                                        ;(define-key global-map '[(conrol shift tab)] 'my-other-window-back)
                                        ;(global-set-key '[(control lefttab)] 'my-other-window-back)

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
(message "3")

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

(mouse-wheel-mode t)

;; ensure we do this *after* default.el is loaded!
(add-hook 'after-init-hook
          '(lambda ()
             (setq require-final-newline nil)))

(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key [(mouse-6)] 'scroll-right)
(global-set-key [(mouse-7)] 'scroll-left)

(message "1")
(load "register")




;; (menu-bar-mode 0)
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

(global-set-key (kbd "C-;") 'find-file-in-project)
(global-set-key (kbd "C-x ;") 'find-file-in-project)
;;(put 'scroll-left 'disabled nil)
(global-set-key (kbd "M-[ D") 'backward-word-nomark)
(global-set-key (kbd "M-[ C") 'forward-word-nomark)


;; (autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)

(message "2")

;; ido configuration
(setq ido-enable-flex-matching t)
(message "2.0.1")
(setq ido-everywhere t)
(message "2.0.2")
(ido-mode 1)
;;(setq ido-use-filename-at-point 'guess)
(message "2.1")
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".org" ".java" ".rb" ".coffee" ".haml" ".js" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))
(message "2.2")
(setq ido-default-file-method 'selected-window)
(message "2.2.1")
(setq ido-default-buffer-method 'selected-window)
(message "2.2.2")
(setq ido-ignore-extensions t)
(message "3")

(global-set-key (kbd "C-=") 'jg-indent-region)
(global-set-key (kbd "C-+") 'jg-unindent-region)

;; In this case, I set C-c 1 and C-c 2 to be your indent unindent commands. You may be better off place them into a particular Evil keymap. You may need to dig around to find a better keymap. It would be something like this.


(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "~/Dropbox/linux/config/lisp/abbrev_defs.el")    ;; definitions from...
(setq save-abbrevs t)              ;; save abbrevs when files are saved
;; you will be asked before the abbreviations are saved
(quietly-read-abbrev-file)       ;; reads the abbreviations file on startup
(dolist (hook '(org-mode-hook
                text-mode-hook))
  (add-hook hook (lambda () (abbrev-mode 1))))


(defun dired-launch-command ()
  (interactive)
  (dired-do-shell-command 
   (case system-type       
     (gnu/linux "gnome-open") ;right for gnome (ubuntu), not for other systems
     (darwin "open"))
   nil
   (dired-get-marked-files t current-prefix-arg)))
(message "4")
(setq dired-load-hook
      (lambda (&rest ignore)
        (define-key dired-mode-map
          "l" 'dired-launch-command)))

(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra"))

(message "5")
(load "org-mode-setup")
(load "my-keys-minor-mode-map")
;;(load "tramp-setup")
(load "color-setup")
(message "6")

(load "evil-setup")

;; (load "slime-setup")

;;(load "org-octopress-setup")
(load "org-octo-jg-publish")

(if (eq system-type 'darwin)
    (load "mac-setup.el")
  (load "linux-setup.el"))

(global-set-key (kbd "<s-wheel-down>") 'text-scale-decrease)
(global-set-key (kbd "<s-wheel-up>") 'text-scale-increase)
(message "7")

(server-start)

(require 'ansi-color)

(defun ansi-colorize-current-buffer ()
  "Colorize ansi escape sequences in the current buffer."
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)


;; https://gist.github.com/jwiegley/5277578
;; (global-set-key "C-c e b" 'do-eval-buffer)
;; (global-set-key "C-c e e" 'toggle-debug-on-error)
;; (global-set-key "C-c e f" 'emacs-lisp-byte-compile-and-load)
;; (global-set-key "C-c e r" 'eval-region)
;; (global-set-key "C-c e s" 'scratch)

;; (global-set-key "C-h e" 'lisp-find-map)

;; (global-set-key "C-h e e" 'view-echo-area-messages)
;; (global-set-key "C-h e f" 'find-function)
;; (global-set-key "C-h e k" 'find-function-on-key)
;; (global-set-key "C-h e l" 'find-library)
;; (global-set-key "C-h e v" 'find-variable)
;; (global-set-key "C-h e V" 'apropos-value)

;; this must go LAST or else color issues  
;; change mode-line color by evil state
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
            (lambda ()
              (let ((color (cond ((minibufferp) default-color)
                                 ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                                 ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                                 ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                                 (t default-color))))
                (set-face-background 'mode-line (car color))
                (set-face-foreground 'mode-line (cdr color))))))



;; debugging setup
(setq edebug-all-defs nil)



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
(set-variable 'magit-emacsclient-executable "/usr/local/bin/emacsclient")

;; http://superuser.com/questions/695761/emacs-right-click-context-menu-on-mac-os/695797?iemail=1&noredirect=1#695797
(global-set-key [mouse-3] 'mouse-buffer-menu)



(defun jta-reformat-xml ()
  "Reformats xml to make it readable (respects current selection)."
  (interactive)
  (save-excursion
    (let ((beg (point-min))
          (end (point-max)))
      (if (and mark-active transient-mark-mode)
          (progn
            (setq beg (min (point) (mark)))
            (setq end (max (point) (mark))))
        (widen))
      (setq end (copy-marker end t))
      (goto-char beg)
      (while (re-search-forward ">\\s-*<" end t)
        (replace-match ">\n<" t t))
      (goto-char beg)
      (indent-region beg end nil))))


(add-hook 'markdown-mode-hook 'turn-on-pandoc)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
;; (load "hacks-to-remove")

(require 'simpleclip)
(simpleclip-mode 1)
