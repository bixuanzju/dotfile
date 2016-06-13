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

(setq proof-general-packages
      '(
        (proof-general :location local)
        company-coq
        ))

(when (configuration-layer/package-usedp 'company)
  (defun proof-general/init-company-coq ()
    (use-package company-coq
      :defer t
      :init (add-hook 'coq-mode-hook #'company-coq-mode)
      :config
      (progn
        (spacemacs/set-leader-keys-for-major-mode 'coq-mode
          "g" 'company-coq-jump-to-definition
          "d" 'company-coq-doc
          "o" 'company-coq-occur)))))

(defun proof-general/init-proof-general ()
  (use-package proof-site
    :load-path "~/PG/generic/"
    :mode ("\\.v\\'" . coq-mode)
    :defer t
    :config
    (progn
      (setq proof-splash-seen t)

      (setq proof-three-window-mode-policy 'hybrid)

      ;; (setq coq-compile-before-require t)

      ;; I don't know who wants to evaluate comments
      ;; one-by-one, but I don't.
      (setq proof-script-fly-past-comments t)

      ;; prefix
      ;; (spacemacs/declare-prefix-for-mode 'coq-mode "mh" "coq/documentation")
      ;; (spacemacs/declare-prefix-for-mode 'coq-mode "mg" "coq/navigation")
      ;; (spacemacs/declare-prefix-for-mode 'coq-mode "ms" "coq/process")

      ;; key bindings
      (spacemacs/set-leader-keys-for-major-mode 'coq-mode
        "." 'proof-goto-end-of-locked

        "]" 'proof-assert-next-command-interactive
        "[" 'proof-undo-last-successful-command
        "n" 'proof-goto-point))))

;;; packages.el ends here
