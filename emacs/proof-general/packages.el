;;; packages.el --- proof-general layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Jeremy Bi <bixuanxbi@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;;; Code:

;; TODO: Make company-ghc work
(setq proof-general-packages
      '(
        (proof-general :location local)
        ;; company
        ;; company-coq
        ))


(defun proof-general/init-proof-general ()
  (use-package proof-site
    :load-path "~/PG/generic/"
    :mode ("\\.v\\'" . coq-mode)
    :defer t
    :config
    (progn
      (setq proof-splash-seen t)

       ;; Hybrid mode is by far the best.
       (setq proof-three-window-mode-policy 'hybrid)

       ;; I don't know who wants to evaluate comments
       ;; one-by-one, but I don't.
       (setq proof-script-fly-past-comments t)

       (spacemacs/set-leader-keys-for-major-mode 'coq-mode
         "n" 'proof-assert-next-command-interactive
         "p" 'proof-undo-last-successful-command
         "c" 'coq-Check))))


;; (defun proof-general/post-init-company ()
;;   (spacemacs|add-company-hook coq-mode))

;; (when (configuration-layer/layer-usedp 'auto-completion)
;;   (defun proof-general/init-company-coq ()
;;     (use-package company-coq
;;       :if (configuration-layer/package-usedp 'company)
;;       :defer t
;;       :init (push 'company-coq-mode company-backends-coq-mode))))

;;; packages.el ends here
