(message "mac-setup.el")

;(setq mac-command-modifier 'control)
;      mac-command-modifier 'ns-control-modifier)
;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  ;; (setq mac-option-modifier 'meta)
  ;;(setq mac-control-modifier 'meta)
  ;;(setq mac-command-modifier 'control)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  (global-set-key '[(meta tab)] 'other-window)
  (global-set-key '[(shift meta tab)] 'my-other-window-back)
  (define-key global-map '[(meta tab)] 'other-window)
  (define-key global-map '[(shift meta tab)] 'my-other-window-back)
  
  (add-hook 'org-mode-hook (lambda ()
                             (define-key org-mode-map (kbd "C-c g") 'omlg-grab-link)))


  ;; From http://lists.gnu.org/archive/html/emacs-devel/2011-02/msg01206.html
  (let ((path-helper
         (lambda (p pd)
           (with-temp-buffer
             (mapc (lambda (filename)
                     (insert-file-contents filename)
                     (goto-char (point-max))
                     (unless (bolp) (insert "\n")))
                   (cons p (directory-files pd t "[^.]")))
             (let (res)
               (goto-char (point-min))
               (while (< (point) (point-max))
                 (setq res (cons (buffer-substring
                                  (point) (progn (end-of-line) (point)))
                                 res))
                 (forward-char 1))
               (nreverse res))))))
    (setq exec-path (funcall path-helper "/etc/paths" "/etc/paths.d"))
    (setenv "PATH" (mapconcat #'identity exec-path ":"))
    (setenv "MANPATH"
            (mapconcat #'identity
                       (funcall path-helper "/etc/manpaths" "/etc/manpaths.d")
                       ":")))


  ; (load-theme 'solarized-dark t)
  ;; (load-theme 'zenburn t)
  ;; (load-theme 'dichromacy t)
  ;; Move to trash when deleting stuff
  (setq delete-by-moving-to-trash t
        trash-directory "~/.Trash/emacs")

  ;; Ignore .DS_Store files with ido mode
  (add-to-list 'ido-ignore-files "\\.DS_Store")
  
)
