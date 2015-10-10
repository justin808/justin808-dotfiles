(message "evil-setup.el")

;; do not do this, or else it will set speedbar to use linum-mode!
;; (global-linum-mode nil)

;; turned this off, b/c causing display issues with emacs beta
;; (add-hook 'find-file-hook (lambda () (linum-mode 1)))



(require 'undo-tree)
(global-undo-tree-mode)

(require 'evil)


(evil-mode 1)

(setq evil-search-module 'evil-search
      evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t
      evil-shift-width 2)
(setq-default evil-shift-width 2)

;; (evil-set-toggle-key "<pause>")

; simulate vim's "nnoremap <space> 10<c-e>10j"
(define-key evil-normal-state-map " " (lambda ()
                     (interactive)
                     (next-line 10)
                     (evil-scroll-line-down 10)
                     ))
; simulate vim's "nnoremap <backspace> 10<c-y>10k"
;; (define-key evil-normal-state-map [backspace] (lambda ()
;;                      (interactive)
;;                      (previous-line 10)
;;                      (evil-scroll-line-up 10)
;;                      ))
;; http://zuttobenkyou.wordpress.com/2011/02/15/some-thoughts-on-emacs-and-vim/
;; simulate vim's "nnoremap <backspace> 10kzz"
(define-key evil-normal-state-map (kbd "DEL") (lambda ()
                                                (interactive)
                                                (previous-line 10)
                                                (evil-scroll-line-up 10)
                                                ))
;; (evil-declare-key 'normal org-mode-map "T" 'org-todo)
;; (evil-declare-key 'normal org-mode-map "-" 'org-cycle-list-bullet)
;; make evil work for org-mode!
;; (define-key evil-normal-state-map "O" (lambda ()
;;                     (interactive)
;;                     (end-of-line)
;;                     (org-insert-heading)
;;                     (evil-append nil)
;;                     ))

(defun always-insert-item ()
     (interactive)
     (if (not (org-in-item-p))
       (insert "\n- ")
       (org-insert-item)))

(defun my-indent-region (N)
  (interactive "p")
  (if mark-active
      (progn (indent-rigidly (min (mark) (point)) (max (mark) (point)) (* N 2))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if mark-active
      (progn (indent-rigidly (min (mark) (point)) (max (mark) (point)) (* N -2))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(define-key evil-normal-state-map (kbd "C-=") 'my-indent-region)
(define-key evil-normal-state-map (kbd "C-+")  'my-unindent-region)

;; (evil-set-initial-state 'magit-status-mode 'emacs)
;; (evil-set-initial-state 'magit-log-edit-mode 'emacs)
;; (evil-set-initial-state 'shell-mode 'emacs)
;; (evil-set-initial-state 'term-mode 'emacs)
;; (evil-set-initial-state 'dired-mode 'emacs)
;; (evil-set-initial-state 'color-theme-mode 'emacs)
;; (evil-set-initial-state 'undo-tree-visualizer-mode 'emacs)
;; (evil-set-initial-state 'minibuffer-mode 'emacs)
;; (evil-set-initial-state 'sql-mode 'emacs)
;; (define-key evil-normal-state-map (kbd "!") 'my-revert-buffer)
;; (define-key evil-normal-state-map (kbd "TAB") 'org-cycle)
(setq evil-default-cursor t)
(setq evil-want-fine-undo t)

;; Remap org-mode meta keys for convenience
(mapcar (lambda (state)
    (evil-declare-key state org-mode-map
      (kbd "M-l") 'org-metaright
      (kbd "M-h") 'org-metaleft
      (kbd "M-k") 'org-metaup
      (kbd "M-j") 'org-metadown
      (kbd "M-L") 'org-shiftmetaright
      (kbd "M-H") 'org-shiftmetaleft
      (kbd "M-K") 'org-shiftmetaup
      (kbd "M-J") 'org-shiftmetadown
      (kbd "M-s-k") 'outline-previous-visible-heading
      (kbd "M-s-j") 'outline-next-visible-heading))
  '(normal insert))


;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(define-key evil-normal-state-map "u" 'undo-tree-undo)
(define-key evil-normal-state-map "\C-r" 'undo-tree-redo)

;; (defun evilnc-default-hotkeys ()
;;   "Set the hotkeys of evil-nerd-comment"
;;   (interactive)
;;   (global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
;;   (global-set-key (kbd "C-c l") 'evilnc-comment-or-uncomment-to-the-line)
;;   (global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
;;   (global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)
;;   (eval-after-load 'evil
;;        (define-key evil-normal-state-map ",ci" 'evilnc-comment-or-uncomment-lines)
;;        (define-key evil-normal-state-map ",cl" 'evilnc-comment-or-uncomment-to-the-line)
;;        (define-key evil-normal-state-map ",cc" 'evilnc-copy-and-comment-lines)
;;        (define-key evil-normal-state-map ",cp" 'evilnc-comment-or-uncomment-paragraphs)
;;        (define-key evil-normal-state-map ",cr" 'comment-or-uncomment-region)
;;        ))

(evilnc-default-hotkeys)

(define-key my-keys-minor-mode-map (kbd "C-/") 'evilnc-comment-uncomment-lines)
(define-key my-keys-minor-mode-map (kbd "C-s-/") 'evilnc-comment-uncomment-lines)
(define-key my-keys-minor-mode-map (kbd "C-M-/") 'evilnc-comment-uncomment-lines)


;; (evilnc-default-hotkeys)
;; if you want these bindings
;; (defun evilnc-default-hotkeys ()
;;   "Set the hotkeys of evil-nerd-comment"
;;   (interactive)
;;   (global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
;;   (global-set-key (kbd "C-c l") 'evilnc-comment-or-uncomment-to-the-line)
;;   (global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
;;   (global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)
;;   (eval-after-load 'evil
;;        (define-key evil-normal-state-map ",ci" 'evilnc-comment-or-uncomment-lines)
;;        (define-key evil-normal-state-map ",cl" 'evilnc-comment-or-uncomment-to-the-line)
;;        (define-key evil-normal-state-map ",cc" 'evilnc-copy-and-comment-lines)
;;        (define-key evil-normal-state-map ",cp" 'evilnc-comment-or-uncomment-paragraphs)
;;        (define-key evil-normal-state-map ",cr" 'comment-or-uncomment-region)
;;        ))

;; (define-key my-keys-minor-mode-map (kbd "C-/")   'evilnc-comment-or-uncomment-lines)
;; (define-key my-keys-minor-mode-map (kbd "C-s-/") 'evilnc-comment-or-uncomment-lines)
(define-key my-keys-minor-mode-map (kbd "C-M-/") 'evilnc-comment-or-uncomment-lines)


;; https://github.com/maio/dotfiles/blob/master/emacs/emacs.d/maio-evil.el
(require 'cl)
(loop for (mode . state) in '((inferior-emacs-lisp-mode      . emacs)
                              (nrepl-mode                    . insert)
                              (pylookup-mode                 . emacs)
                              (comint-mode                   . normal)
                              (shell-mode                    . insert)
                              (git-commit-mode               . insert)
                              (git-rebase-mode               . emacs)
                              (term-mode                     . emacs)
                              (help-mode                     . emacs)
                              (helm-grep-mode                . emacs)
                              (grep-mode                     . emacs)
                              (rmail-mode                    . normal)
                              (rmail-summary-mode            . emacs)
                              (bc-menu-mode                  . emacs)
                              (magit-branch-manager-mode     . emacs)
                              (rdictcc-buffer-mode           . emacs)
                              (dired-mode                    . normal)
                              (wdired-mode                   . normal))
      do (evil-set-initial-state mode state))

(setq x-select-enable-clipboard nil)

;; this replacement must go after evil is loaded
(defun evil-visual-update-x-selection (&optional buffer)
  "Update the X selection with the current visual region."
  (let ((buf (or buffer (current-buffer))))
    (when (buffer-live-p buf)
      (with-current-buffer buf
        (when (and (evil-visual-state-p)
                   (fboundp 'x-select-text)
                   (or (not (boundp 'ns-initialized))
                       (with-no-warnings ns-initialized))
                   (not (eq evil-visual-selection 'block)))
          ;; CHANGE
          ;; ONLY call x-select-text if x-select-enable-clipboard is true
          (if x-select-enable-clipboard
              (x-select-text (buffer-substring-no-properties
                              evil-visual-beginning
                              evil-visual-end))))))))

; Overload shifts so that they don't lose the selection
(define-key evil-visual-state-map (kbd ">") 'djoyner/evil-shift-right-visual)
(define-key evil-visual-state-map (kbd "<") 'djoyner/evil-shift-left-visual)
(define-key evil-visual-state-map [tab] 'djoyner/evil-shift-right-visual)
(define-key evil-visual-state-map [S-tab] 'djoyner/evil-shift-left-visual)

(defun djoyner/evil-shift-left-visual ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun djoyner/evil-shift-right-visual ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))
