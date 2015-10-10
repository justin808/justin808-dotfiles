;(fset 'p4edit
;   [?\C-y ?\C-a ?\C-\M-% ?\\ ?\\ return ?/ return ?! ?\C-a ?\C-d ?\C-d ?/ ?c ?\C-b ?\C-b ?p ?4 ?  ?e ?d ?i ?t ?  ?\C-e return])
;(global-set-key [(meta f11)] 'p4edit)

;(fset 'p4submit
;   [?\C-s ?< ?\C-k backspace ?B ?u ?g ?: return tab ?C ?a ?u ?s ?e ?: return tab ?S ?o ?l ?u ?t ?i ?o ?n ?: return tab ?R ?e ?v ?i ?e ?w ?e ?r ?: ?\C-p ?\C-p ?\C-p ?\C-e ? ])
;(global-set-key [(meta f10)] 'p4submit)


;(defalias 'p4submit
;  (read-kbd-macro "
;C-s			;; isearch-forward
;<			;; self-insert-command
;C-k			;; kill-line
;DEL			;; backward-delete-char-untabify
;Bug:
;SPC
;WPC00000000      ;; self-insert-command * 4
;RET			;; newline-and-indent
;TAB			;; lisp-indent-line
;Cause:			;; self-insert-command * 6
;RET			;; newline-and-indent
;TAB			;; lisp-indent-line
;Solution:		;; self-insert-command * 9
;RET			;; newline-and-indent
;TAB			;; lisp-indent-line
;JUnit:		;; self-insert-command * 9
;RET			;; newline-and-indent
;TAB			;; lisp-indent-line
;Reviewer:		;; self-insert-command * 9
;RET			;; newline-and-indent
;TAB			;; lisp-indent-line
;Reviewer
;SPC
;Comments:	;; self-insert-command * 9
;3*C-p			;; previous-line
;C-e			;; end-of-line
;SPC			;; self-insert-command
;"))
;;(global-set-key [(meta f10)] 'p4submit)



;;; P4
;;(load-library "p4")
;;(p4-toggle-vc-mode-off)
;;(setq p4-do-find-file t)

;(load "color-font-frame")


;; for some reason, this needs to be last
;; (setq initial-frame-alist '
;;       (
;;        (tool-bar-lines . 0)
;;        (menu-bar-lines . 1)
;;        (width . 100)
;;        (height . 61)
;;        (vertical-scroll-bars)
;;        (toolbar . 0)
;;        (background-color . "black")
;;        (background-mode . dark)
;;        (border-color . "blue")
;;        (cursor-color . "yellow")
;;        (foreground-color . "white")
;;        (mouse-color . "black")
;;        ;;(font . "-Misc-Fixed-Medium-R-Normal--14-130-75-75-C-70-ISO8859-1")
;;        )
;;       )
;; (setq default-frame-alist initial-frame-alist)

(fset 'chmodi
   [?\C-y ?\C-a ?\C-\M-% ?\\ ?\\ return ?/ return ?! ?\C-a ?\C-d ?\C-d ?/ ?c ?\C-b ?\C-b ?c ?h ?m ?o ?d ?  ?+ ?w ?  ?\C-e return])
(global-set-key [(meta f12)] 'chmodi)

;; (global-set-key     '[(meta backspace)] 'backward-kill-word)
;; (global-set-key     '[(meta delete)] 'backward-kill-word)

;; (global-set-key '[(shift f12)] 'my-other-frame-back)
;; (global-set-key '[(f12)] 'other-frame)
;; (global-set-key '[(control f12)] 'my-find-file-at-point-other-window)
;; (global-set-key '[(control meta f12)] 'my-find-file-at-point)

;; MACROS!!
;; (fset 'jg-find-next-tag
;;    "\C-u\256")
;; (fset 'jg-find-prev-tag
;;    [?\C-- ?\M-.])

;; (global-set-key [(control meta .)] 'find-tag)
;; (global-set-key [(meta .)] 'xref-browse-symbol)
;; (global-set-key [(control meta t)] 'jg-find-next-tag)
;; (global-set-key [(shift f2)] 'jg-find-prev-tag)
