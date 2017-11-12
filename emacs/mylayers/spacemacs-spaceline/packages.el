;;; packages.el --- spacemacs-spaceline layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Jeremy Bi <jeremybi@Jeremy-MBP.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `spacemacs-spaceline-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `spacemacs-spaceline/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `spacemacs-spaceline/pre-init-PACKAGE' and/or
;;   `spacemacs-spaceline/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst spacemacs-spaceline-packages
  '(spaceline
    spaceline-all-the-icons
    all-the-icons))

;; (defun spacemacs-spaceline/init-all-the-icons ()
;;   (use-package all-the-icons
;;     :config (setq neo-theme 'icons)))

;; (defun spacemacs-spaceline/init-spaceline ()
;;   (use-package spaceline))

(defun spacemacs-spaceline/init-spaceline-all-the-icons ()
  (use-package spaceline-all-the-icons
    :after spaceline
    :config (progn
              (spaceline-all-the-icons-theme))))



;;; packages.el ends here
