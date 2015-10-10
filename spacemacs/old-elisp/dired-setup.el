(message "dired-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIRED
(setq dired-omit-extensions
      (list "CVS/" ".o" "~" ".bin" ".bak" ".obj"
            ".map" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot"
            ".dvi" ".fmt" ".tfm" ".class" ".fas" ".lib" ".x86f" ".sparcf" ".lo"
            ".la" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns"
            ".kys" ".pgs" ".tps" ".vrs" ".idx" ".lof" ".lot" ".glo" ".blg" ".bbl"
            ".cp" ".cps" ".fn" ".fns" ".ky" ".kys" ".pg" ".pgs" ".tp" ".tps" ".vr"
            ".vrs"))
(setq dired-no-confirm
       (list
    'create-top-dir
    'revert-subdirs
        ))



;; dired-x is by default for XEmacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired-x)
(defun my-dired-mode-hook ()
  (define-key dired-mode-map [(meta o)] 'dired-omit-mode)
  (message "my-dired-mode-hook")
  (dired-omit-mode)
  (font-lock-fontify-buffer)
  (set (make-local-variable 'ido-enable-replace-completing-read) nil)
)
(add-hook 'dired-mode-hook 'my-dired-mode-hook)

;; (require 'dired-single)
;; (defun my-dired-init ()
;;   "Bunch of stuff to run for dired, either immediately or when it's
;;         loaded."
;;   ;; <add other stuff here>
;;   (define-key dired-mode-map [return] 'dired-single-buffer)
;;   (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
;;   (define-key dired-mode-map "^"
;;     (function
;;      (lambda nil (interactive) (dired-single-buffer "..")))))

;; ;; if dired's already loaded, then the keymap will be bound
;; (if (boundp 'dired-mode-map)
;;     ;; we're good to go; just add our bindings
;;     (my-dired-init)
;;   ;; it's not loaded yet, so add our bindings to the load-hook
;;   (add-hook 'dired-load-hook 'my-dired-init))





