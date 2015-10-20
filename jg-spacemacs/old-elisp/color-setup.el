(message "color-setup.el")
;; (require 'color-theme-solarized)
; https://github.com/sellout/emacs-color-theme-solarized
;(load-theme solarized-[light|dark] t)
;; (color-theme-solarized-light)
;;(require 'color-theme-railscasts)
;; (color-theme-railscasts)

;;(require 'multi-term)
;;(setq multi-term-program "/bin/bash")
(setq term-ansi-default-program "/bin/bash")


;; http://stackoverflow.com/questions/4642835/how-to-change-the-cursor-color-on-emacs
;; (setq default-frame-alist
  ;; '((cursor-color . "palegoldenrod")))
;; (add-to-list 'default-frame-alist '(cursor-color . "palegoldenrod"))

;; (require 'ansi-color)
;; put colors at END!!!
;; next line works well with railscasts colors
;;(setq ansi-color-names-vector ["black" "tomato" "PaleGreen2" "gold1" "DeepSkyBlue1" "MediumOrchid1" "cyan" "white"])
;; (setq ansi-color-names-vector [unspecified "grey30" "red2" "spring green" "yellow2" "steel blue" "magenta2" "cyan2" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (setq ansi-term-color-vector [unspecified "grey30" "red2" "spring green" "yellow2" "steel blue" "magenta2" "cyan2" "white"])
(setq ansi-color-names-vector ["burlywood" "tomato" "PaleGreen2" "gold1" "DeepSkyBlue1" "MediumOrchid1" "cyan" "light gray"])
(setq ansi-term-color-vector ansi-color-names-vector)
(custom-set-faces)

;; (add-hook 'window-setup-hook '(lambda () (set-cursor-color "goldenrod")))
;; (add-hook 'after-make-frame-functions '(lambda (f) (with-selected-frame f (set-cursor-color "goldenrod"))))
