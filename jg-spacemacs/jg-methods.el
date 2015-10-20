(message "jg-methods.el")
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))

(defun camelize-previous-snake (&optional beg end)
  "Camelize the previous snake cased string.

    If transient-mark-mode is active and a region is activated,
    camelize the region."
  (interactive "r")
  (unless (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
    (setq end (point)
          beg (+ (point) (skip-chars-backward "[:alnum:]_"))))
  (save-excursion
    (let ((c (camelize (buffer-substring-no-properties beg end))))
      (delete-region beg end)
      (goto-char beg)
      (insert c))))


(defun jg-indent-region ()
  (interactive)
  (save-restriction
    (narrow-to-region (region-beginning) (region-end))
    (beginning-of-buffer)
    (while (< (point) (point-max))
      (insert-char ?\s 1)
      (forward-line))
    )
  (setq deactivate-mark nil))

(defun jg-unindent-region ()
  (interactive)
  (save-restriction
    (narrow-to-region (region-beginning) (region-end))
    (beginning-of-buffer)
    (while (< (point) (point-max))
      (delete-char 1)
      (forward-line))
    )
  (setq deactivate-mark nil))


