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

       (setq proof-three-window-mode-policy 'smart)

       ;; I don't know who wants to evaluate comments
       ;; one-by-one, but I don't.
       (setq proof-script-fly-past-comments t)

       ;; prefix
       (spacemacs/declare-prefix-for-mode 'coq-mode "mh" "coq/documentation")
       (spacemacs/declare-prefix-for-mode 'coq-mode "mg" "coq/navigation")
       (spacemacs/declare-prefix-for-mode 'coq-mode "ms" "coq/process")

       ;; key bindings
       (spacemacs/set-leader-keys-for-major-mode 'coq-mode
         "g." 'proof-goto-end-of-locked

         "sn" 'proof-assert-next-command-interactive
         "su" 'proof-undo-last-successful-command
         "sN" 'proof-goto-point

         "ht" 'proof-query-identifier)
       )))


;; (defun proof-general/post-init-company ()
;;   (spacemacs|add-company-hook coq-mode))

;; (when (configuration-layer/layer-usedp 'auto-completion)
;;   (defun proof-general/init-company-coq ()
;;     (use-package company-coq
;;       :if (configuration-layer/package-usedp 'company)
;;       :defer t
;;       :init (push 'company-coq-mode company-backends-coq-mode))))

;;; packages.el ends here
