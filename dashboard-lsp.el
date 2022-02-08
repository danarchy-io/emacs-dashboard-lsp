;;; dashboard-lsp.el --- A emacs-dashboard widget configuration for Lsp  -*- lexical-binding: t -*-

;; Copyright (c) 2022 emacs-dashboard-lsp maintainers
;;
;; Author     : Gabriel Tejeda <gtejeda@danarchy.io>
;; Maintainer : Gabriel Tejeda <gtejeda@danarchy.io>
;;              Alexis Tejeda <atejeda@danarchy.io>
;; URL        : https://github.com/danarchy-io/emacs-dashboard-lsp
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
;;
;; Created: October 08, 2022
;; Package-Version: 1.0
;; Keywords: startup, screen, tools, dashboard
;; Package-Requires: ((emacs "26.1"))
;;; Commentary:

;; A emacs-dashboard widget configuration for Lsp.

;;; Code:
(require 'cl-lib)

;; Compiler pacifier
(declare-function lsp-mode "ext:lsp-mode.el")
(declare-function lsp-session-folders "ext:lsp-mode.el")
(declare-function lsp-session "ext:lsp-mode.el")
(declare-function lsp-mode "ext:lsp-mode.el")
(declare-function lsp-session-folders "ext:lsp-mode.el")
(declare-function lsp-session "ext:lsp-mode.el")
(declare-function dashboard "ext:dashboard.el")
(declare-function dashboard-insert-section "ext:dashboard-widgets.el")
(declare-function dashboard-shorten-paths "ext:dashboard-widgets.el")
(declare-function dashboard-get-shortcut "ext:dashboard-widgets.el")
(declare-function dashboard-expand-path-alist "ext:dashboard-widgets.el")
(declare-function dashboard-extract-key-path-alist "ext:dashboard-widgets.el")

;;
;; Lsp Session folders
;;
(defun dashboard-lsp-setup ()
  "Setup dashboard-lsp."
  (require 'dashboard)
  (defvar dashboard-lsp-folders-alist nil
    "Alist records shorten's LSP Workspace folders and it's full paths.")

  (defun dashboard-insert-lsp-folders (list-size)
    "Add the list of LIST-SIZE items of lsp session folders."
    (require 'lsp-mode)
    (dashboard-insert-section
     "Lsp Session folders:"
     (dashboard-shorten-paths (lsp-session-folders (lsp-session)) 'dashboard-lsp-folders-alist 'lsp-folders)
     list-size
     'lsp-folders
     (dashboard-get-shortcut 'lsp-folders)
     `(lambda (&rest _)
        (find-file-existing (dashboard-expand-path-alist ,el dashboard-lsp-folders-alist)))
     (dashboard-extract-key-path-alist el dashboard-lsp-folders-alist)))
  
  (add-to-list 'dashboard-item-generators '(lsp-folders . dashboard-insert-lsp-folders))
  (add-to-list 'dashboard-items '(lsp-folders) t)
  (add-to-list 'dashboard-item-shortcuts '(lsp-folders . "l") t))

(provide 'dashboard-lsp)
;;; dashboard-lsp.el ends here

