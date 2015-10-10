(remove-hook 'ruby-mode-hook 'ruby-electric-mode)
 
; enable and disable ruby-electric-mode to stop ruby-mode 
; from handling curly braces
(defun ruby-mode-hook-for-fixing-ruby-electric ()
  (require 'ruby-electric)
  (ruby-electric-mode)
  (ruby-electric-mode -1))
(add-hook 'ruby-mode-hook 
          'ruby-mode-hook-for-fixing-ruby-electric)
