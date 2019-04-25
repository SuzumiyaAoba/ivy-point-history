;;; ivy-point-history --- point-history with ivy interface

;; Copyright (C) 2019 SuzumiyaAoba

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

;; Author: SuzumiyaAoba
;; Package-Requires: ((point-history "0.1.0") (ivy "0.11.0"))
;; URL: https://github.com/SuzumiyaAoba/ivy-point-history
;; Version: 0.0.1

;;; Commentary:

;; This package require `point-history`.
;; see https://github.com/blue0513/point-history.

;;; Code:

(require 'ivy)
(require 'point-history)

(defun ivy-point-history--list-candidates ()
  (let* ((points point-history-list)
	 (header "buffer:content"))
    (point-history--save-last-visited-buffer! (current-buffer))
    (point-history--save-last-previewed-buffer! (current-buffer))
    (mapcar (lambda (point)
                (let* ((pos-info (format "%s" (marker-position (nth 0 point))))
	               (buffer-info (format "%s" (marker-buffer (nth 0 point))))
	               (content-info (format "%s" (nth 1 point)))
	               (str (concat buffer-info ": " content-info)))
                  (propertize str
                              'point-history-buffer buffer-info
                              'point-history-position pos-info)))
            points)))

(defun ivy-point-history--action (point)
  (let* ((buffer-name (get-text-property 0 'point-history-buffer point))
         (buffer (get-buffer buffer-name))
	 (pos-str (get-text-property 0 'point-history-position point))
         (pos (string-to-number pos-str)))
    (if (null buffer-name)
	(message "No point at this line.")
      (with-ivy-window
        (switch-to-buffer buffer-name)
        (goto-char pos)))))

(defun ivy-point-history ()
  "Ivy interface for point-history."
  (interactive)
  (ivy-read "point-history: " (ivy-point-history--list-candidates)
            :preselect (ivy-thing-at-point)
            :require-match t
            :sort nil
            :update-fn 'auto
            :action #'ivy-point-history--action
            :caller 'ivy-point-history))

(provide 'ivy-point-history)

;;; ivy-point-history.el ends here
