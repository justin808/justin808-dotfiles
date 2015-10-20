(message "jg-util-funcs.el")
;; These are functions that work on both XEmacs and GNU Emacs
;; IMPT: Make sure to comment out this line in igrep.el: ;;(defalias 'grep-find 'igrep-find)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;  TITLE BAR

(defvar my-system-name (system-name)
  "The name of the system we are running on.")
(display-time)
(setq frame-title-format
      '("%S: " (buffer-file-name "%f" (dired-directory dired-directory "%b"))))
(cond (window-system
       (setq frame-title-format 
             '( ("" invocation-name "@" my-system-name)
                "    "
                ("%S: " (buffer-file-name "%f" (dired-directory dired-directory "%b")))
                "    " 
                display-time-string))
       ;; Per default, the time and date goes into the mode line.
       ;; We want's it in the header line, so lets remove it.
       (remove-hook 'global-mode-string 'display-time-string)))


(defun my-toggle-line-wrap ()
  "Turns line truncation off if it's on, and vice-versa."
  (interactive)
  (set-variable 'truncate-lines (not truncate-lines))
  (set-variable 'truncate-partial-width-windows (not truncate-partial-width-windows))
  ;; Odd... before version 19.30, this 'recenter' wasn't necessary.
  (recenter (+ (count-lines (window-start) (point))
               (if (= (current-column) 0)
                   1
                 0)
               -1))
  (message (format "truncate-lines has been set to %s"
                   (prin1-to-string truncate-lines))))


(defun my-toggle-tab-width ()
  "toggle tab width from 2 to 4"
  (interactive)
  (if (eq tab-width 2)
      (progn
        (setq tab-width 4)
        (setq-default tab-width 4)
        )
    (progn
      (setq tab-width 2)
      (setq-default tab-width 2)
      ))
  (message (concat "set tab width to " (int-to-string tab-width)))
  ;; just setting the variable does not seem to do anything
  (recenter)
  )


;;; Here's my version
(defun my-insert-braces ()
  "Insert matched braces, leave point inside."
  (interactive "*")
  (insert
   (if (and (eq major-mode 'cc-c++-mode) (not (looking-at ";")))
       "{

};" "{

}"))
  (backward-sexp 1)
  (c-indent-exp)
  (forward-char 2)
  (c-indent-command)
  )


(defun my-revert-buffer ()
  "Revert with no confirm if buffer not modified"
  (interactive)
  (if (buffer-modified-p)
      (revert-buffer)
    (revert-buffer nil t)))

(defun my-revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )

(defun my-detab (width)
  "Replace all tabs in buffer with spaces. Prompt for tab width to use."
  (interactive "nTab width: ")
  (let ((tab-width width))
    (untabify (point-min) (point-max))))

;;;  If you have loaded a file as binary that actually has the ^M's in it,
;;;  then switching to text mode will remove them in the buffer.  Of course
;;;  now that it's in text mode, it will save with the ^M's inserted.
;;;  Switching to binary mode does NOT have a reverse effect.  If you want
;;;  to disable that change on entering text mode, then use a negative
;;;  prefix argument, as described below.

;;;  A prefix argument will force the mode change in a particular
;;;  direction.  A positive prefix argument forces it to binary.  A zero
;;;  prefix argument forces text mode allowing the removal of ^M's (only
;;;  preceding ^J's).  A negative prefix argument forces text mode
;;;  disallowing the removal of ^M's.  

;;;  When the mode is changed the state of modification of the buffer is
;;;  preserved, even if the ^M's are removed.

(defun my-toggle-buffer-file-type (arg)
  "Alternate value of buffer-file-type"
  (interactive "P")
  (let ((old buffer-file-type)
        (mod (buffer-modified-p))
        (buffer-read-only nil))
    (setq buffer-file-type
          (if arg (>= arg 1)
            (not buffer-file-type)))
    (if (and old
             (not buffer-file-type)
             (or (not arg)
                 (> arg -2)))
        (save-excursion
          (beginning-of-buffer)
          (while (search-forward "\r\n" nil t)
            (replace-match "\n" nil t))
          (set-buffer-modified-p mod))))
  (force-mode-line-update))



(defun my-show-java-funcs ()
  "toggle selective display"
  (interactive)
  (let
      ((s (+ jg-tab-width 1)))
    (progn
      (if (eq selective-display s)
          (set-selective-display 0)
        (set-selective-display s))
      )
    )
  )

(defun my-display-date-function ()
  "Print the current date in Day Month Day, Year format"
  (let
      (
       (my-time (current-time-string))
       my-year)
    (setq my-year (substring my-time 20 24))
    (concat (substring my-time 0 10) ", " my-year)
    )
  )

(defun my-display-time-function ()
  "Print the current time in am/pm format."
  (let ((time (current-time-string))
        hour am-pm-flag)
    (setq hour (read (substring time 11 13)))
    (if (not display-time-24hr-format)
        (progn
          (setq am-pm-flag (if (>= hour 12) "pm" "am"))
          (if (> hour 12)
              (setq hour (- hour 12))
            (if (= hour 0)
                (setq hour 12))))
      (setq am-pm-flag ""))
	  (concat (format "%d" hour) (substring time 13 16)
            am-pm-flag)))

(defun my-print-current-date ()
  "Inserts current-time-string in buffer."
  (interactive)
  (insert (my-display-date-function))
  )

(defun my-print-current-time ()
  "Inserts current-time-string in buffer."
  (interactive)
  (insert (my-display-time-function))
  )

(defun my-copy-rectangle (start end)
  "Save rectangle with corners at point and mark as last killed rectangle.
Calling from program, supply two args START and END, buffer positions."
  (interactive "r")
  (extract-rectangle start end))

;;
;; Override the default definition of just-one-space so that by default,
;; it removes whitespace including newlines.  A prefix arg will cause it
;; to not eat newlines.
;;

(defun my-just-one-space (arg)
  "Delete all spaces and tabs around point, leaving one space."
  (interactive "*P")
  (expand-abbrev)
  (if arg (skip-chars-backward " \t") (skip-chars-backward " \t\n"))
  (if (= (following-char) ? )
      (forward-char 1)
    (insert ? ))
  (delete-region (point) (progn
                           (if arg
                               (skip-chars-forward " \t")
                             (skip-chars-forward " \t\n"))
                           (point))))




(defun my-toggle-case-fold-search ()
  "Turns case-fold-search off if it's on, and vice-versa."
  (interactive)
  (set-variable 'case-fold-search (not case-fold-search))
  (message (format "case-fold-search has been set to %s"
                   (prin1-to-string case-fold-search))))

(defun my-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))



(defun my-remove-linefeeds ()
  "This function removes the linefeeds from a file."
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (while (search-forward "\r\n" nil t)
      (replace-match "\n" nil t))
    ))

;;  (defun my-no-cr ()
;;    "delete CRs at end of line in the whole buffer"
;;    (interactive)
;;    (save-excursion
;;      (goto-char (point-min))
;;      (replace-regexp "$" "")
;;      (replace-regexp "$" "")))


(defun my-other-frame-back ()
  "Move backwards through frames"
  (interactive)
  (other-frame -1)
  )

(defun my-other-window-back ()
  "Move backwards through windows"
  (interactive)
  (other-window -1)
  )


;;; ----------------------------------------------------------------------
;;;
                                        ;(defun my-indented-text-mode-hook ()
                                        ;  "My mode settings."
                                        ;  ;; Let's modify the CR key to indent autpmatically
                                        ;  (define-key indented-text-mode-map "\C-m" 'my-auto-indent)
                                        ;  )


;;; ----------------------------------------------------------------------
;;;
(defun my-return-key-toggle ()
  "Toggles auto indent/regular newline ."
  (interactive)
  (local-set-key
   "\C-m"
   (if (equal (or (lookup-key  (current-local-map) "\C-m")
                  (lookup-key  (current-global-map) "\C-m"))
              'my-auto-indent)
       (progn
         (message "normal.")
         'newline)
     (progn
       (message "Indent on")
       'my-auto-indent
       ))))


;;; ----------------------------------------------------------------------
;;; Replaces the RET key
;;; The arg is just due to: (newline &optional ARG1)
;;;
(defun my-auto-indent (&optional arg)
  "Automatically indent according to previous line.
If optional ARG is given, behave exactly like 'newline' function.
"
  (interactive "P")
  (let(str
       )
    ;;  Let's peek current line
    (save-excursion
      (beginning-of-line)
      (if (looking-at "^[ \t]+")
          (setq str (buffer-substring (match-beginning 0) (match-end 0)))
        ))
    ;;  We do not do anything special if user has given arg.
    (if arg
        (newline arg)
      (newline)
      (if str (insert str)))
    ))



                                        ;(defun my-fill-paragraph(arg)
                                        ;  "Fill the current region, if it's active; otherwise, fill the paragraph.
                                        ;See `fill-paragraph' and `fill-region' for more information."
                                        ;  (interactive "*P")
                                        ;  (if (and zmacs-regions (mark))
                                        ;      (fill-region (point) (mark) arg)
                                        ;    (fill-individual-paragraphs arg)))



(defun my-jump-mark-ring()
  "Move through mark ring."
  (interactive)
  (set-mark-command 1)
  )




(defun which (exe &optional showall)
  "Show the full path name of an executable.
This command searches the directories in `exec-path'"
  (interactive "sWhich: ")
  (catch 'answer
    (mapcar
     '(lambda (dir)
        (mapcar
         '(lambda (suf)
            (let ((try (expand-file-name (concat exe suf) dir)))
              (and (file-executable-p try)
                   (null (file-directory-p try))
                   (progn
                     (message "%s is %s" exe try)
                     (throw 'answer try)))))
         '("")))
     exec-path)
    (message "Can't find %s in search path" exe)
    nil))



(defun slide-in (start end &optional prefix)
  "Indents the region in the current buffer using optional insert PREFIX.
When called from within Lisp code, expects START and END as first args."
  (interactive
   (list (min (point) (mark))
         (max (point) (mark))
         (read-string (format "Prefix [%s]: " comment-start) comment-start)))
  (save-excursion
    (goto-char start)
    (beginning-of-line 1)
    (while (< (point) end)
      (insert prefix)
      (beginning-of-line 2))))

(defun common-leader (s1 s2)
  (let ((s1len (length s1))
        (s2len (length s2))
        (i 0))
    (while (and (< i s1len) (< i s2len) (char-equal (aref s1 i) (aref s2 i)))
      (setq i (1+ i)))
    (substring s1 0 i)))

(defun slide-out (start end &optional prefix)
  "Out-dents the region in the current buffer, removing either the common
prefix of the first two lines, or optional arg PREFIX.
When called from within Lisp code, expects START and END as first args."
  (interactive
   (list (min (point) (mark))
         (max (point) (mark))
         (save-excursion
           (goto-char (min (point) (mark)))
           (let* ((line1 (buffer-substring (point) (progn (end-of-line 1) (point))))
                  (line2 (buffer-substring (progn (beginning-of-line 2) (point))
                                           (progn (end-of-line 1) (point))))
                  (prefix (common-leader line1 line2)))
             (read-string "Prefix: " prefix)))))

  (goto-char start)
  (beginning-of-line 1)
  (setq prefix (regexp-quote prefix))
  (setq end (set-marker (make-marker) end))
  (while (< (point) end)
    (if (looking-at prefix)
        (delete-region (match-beginning 0) (match-end 0)))
    (forward-line 1)))




;; from the xemacs source
(defun switch-to-other-buffer (arg)
  "Switch to the previous buffer.  With a numeric arg, n, switch to the nth
most recent buffer.  With an arg of 0, buries the current buffer at the
bottom of the buffer stack."
  (interactive "p")
  (if (eq arg 0)
      (bury-buffer (current-buffer)))
  (switch-to-buffer
   (if (<= arg 1) (other-buffer (current-buffer))
     (nth (1+ arg) (buffer-list)))))




(defun shell-create ()
  (interactive)
  (if (not (boundp 'shell-count))
      (defvar shell-count 1)
    (setq shell-count (+ shell-count 1)))
  (shell)
  (rename-buffer (concat "*shell" (int-to-string shell-count)  ) t)
  )

(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'unix 't) )

(defun color-ansi()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)) 
  )


;; http://superuser.com/questions/361566/zsh-completion-will-not-work-in-emacs-shell
(defun term-switch-to-shell-mode ()
  (interactive)
  (shell-mode)
  (set-process-filter  (get-buffer-process (current-buffer)) 'comint-output-filter )
  (compilation-shell-minor-mode 1)
  (comint-send-input))
(defun shell-switch-to-term-mode ()
  (compilation-shell-minor-mode -1)
  (font-lock-mode -1)
  (set-process-filter  (get-buffer-process (current-buffer)) 'term-emulate-terminal)
  (term-mode)
  (term-char-mode)
  (term-send-raw-string (kbd "C-l")))

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


