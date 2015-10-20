;; http://unix.stackexchange.com/questions/29786/font-size-issues-with-emacs-in-linum-mode
;; This script is set for a `text-scale-mode-step` of `1.04`
;; not loading -- not taking the time to figure this one out...
(setq text-scale-mode-step 1.04)
;;
;; List: `Sub-Zoom Font Heights per text-scale-mode-step`  
;;   eg.  For a default font-height of 120 just remove the leading `160 150 140 130` 
(defvar sub-zoom-ht (list 160 150 140 130 120 120 110 100 100  90  80  80  80  80  70  70  60  60  50  50  50  40  40  40  30  20  20  20  20  20  20  10  10  10  10  10  10  10  10  10  10   5   5   5   5   5   2   2   2   2   2   2   2   2   1   1   1   1   1   1   1   1   1   1   1   1))
(defvar sub-zoom-len (safe-length sub-zoom-ht))
(defvar def-zoom-ht (car sub-zoom-ht))
(set-face-attribute 'default nil :height def-zoom-ht)

(defun text-scale-adjust-zAp ()
   (interactive)
   (text-scale-adjust 0)
   (set-face-attribute 'linum nil :height def-zoom-ht)
 )
(global-set-key [C-kp-multiply] 'text-scale-adjust-zAp)

(defun text-scale-decrease-zAp ()
   (interactive)
   (if (not (boundp 'text-scale-mode-amount)) ;; first-time init  
              (setq  text-scale-mode-amount 0))
   (setq text-scale (round (/ (* 1 text-scale-mode-amount) 
                                   text-scale-mode-step)))
   (if (> text-scale (- 1 sub-zoom-len))
       (progn
         (text-scale-decrease text-scale-mode-step)
         (if (<= 0 text-scale-mode-amount)
             (set-face-attribute 'linum nil :height def-zoom-ht)
           (if (> 0 text-scale-mode-amount)
               (set-face-attribute 'linum nil :height 
                                     (elt sub-zoom-ht (- 0 text-scale)))))))
)
(global-set-key [C-kp-subtract] 'text-scale-decrease-zAp)

(defun text-scale-increase-zAp ()
   (interactive)
   (if (not (boundp 'text-scale-mode-amount)) ;; first-time init  
              (setq  text-scale-mode-amount 0))
   (setq text-scale (round (/ (* 1 text-scale-mode-amount) 
                                   text-scale-mode-step)))
   (if (< text-scale 85)
       (progn
         (text-scale-increase text-scale-mode-step)
         (if (< (- 0 text-scale-mode-step) text-scale-mode-amount)
             (set-face-attribute 'linum nil :height def-zoom-ht)
           (if (> 0 text-scale-mode-amount)
               (set-face-attribute 'linum nil :height 
                                     (elt sub-zoom-ht (- 0 text-scale)))))))
)
(global-set-key [C-kp-add] 'text-scale-increase-zAp)


;; Zoom font via Numeric Keypad
(global-set-key [C-kp-multiply] 'text-scale-adjust-zAp)
(global-set-key [C-kp-subtract] 'text-scale-decrease-zAp)
(global-set-key [C-kp-add]      'text-scale-increase-zAp)

;; Zoomf font via Control Mouse Wheel
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase-zAp)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease-zAp)
