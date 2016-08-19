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
        (company-coq :toggle (configuration-layer/package-usedp 'company))
        smartparens
        ))

(defun proof-general/init-company-coq ()
  (use-package company-coq
    :defer t
    :init (add-hook 'coq-mode-hook #'company-coq-mode)
    :config
    (progn
      (spacemacs/declare-prefix-for-mode
       'coq-mode
       "mi" "coq/insert")
      (spacemacs/set-leader-keys-for-major-mode 'coq-mode
        "il" 'company-coq-lemma-from-goal
        "im" 'company-coq-insert-match-construct
        "gd" 'company-coq-jump-to-definition))))

;; brew install texi2html
;; brew install proof-general --HEAD
;; Credits to https://github.com/tchajed/spacemacs-coq
(defun proof-general/init-proof-general ()
  (use-package proof-site
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

      (dolist (prefix '(("ml" . "pg/layout")
                        ("mp" . "pg/prover")
                        ("ma" . "pg/ask-prover")
                        ("mai" . "show-implicits")
                        ("man" . "show-all") ; n is for notation
                        ("mg" . "pg/goto")))
        (spacemacs/declare-prefix-for-mode
         'coq-mode
         (car prefix) (cdr prefix)))

      ;; key bindings
      (spacemacs/set-leader-keys-for-major-mode 'coq-mode
        ;; Basic proof management
        "]" 'proof-assert-next-command-interactive
        "[" 'proof-undo-last-successful-command
        "." 'proof-goto-point
        ;; Layout
        "ll" 'proof-layout-windows
        "lc" 'pg-response-clear-displays
        "lp" 'proof-prf
        ;; Prover Interaction
        "px" 'proof-shell-exit
        "pc" 'proof-interrupt-process
        "pr" 'proof-retract-buffer
        "pb" 'proof-process-buffer
        ;; Prover queries ('ask prover')
        "af" 'proof-find-theorems
        "ap" 'coq-Print
        "ac" 'coq-Check
        "ab" 'coq-About
        "aip" 'coq-Print-with-implicits
        "aic" 'coq-Check-show-implicits
        "aib" 'coq-About-with-implicits
        "anp" 'coq-Print-with-all
        "anc" 'coq-Check-show-all
        "anb" 'coq-About-with-all
        ;; Moving the point (goto)
        "g." 'proof-goto-end-of-locked
        "ga" 'proof-goto-command-start
        "ge" 'proof-goto-command-end
        ;; Insertions
        "ie" 'coq-end-Section)
      )))

(defun proof-general/post-init-smartparens ()
  (spacemacs/add-to-hooks
   (if dotspacemacs-smartparens-strict-mode
       'smartparens-strict-mode
     'smartparens-mode)
   '(coq-mode-hook)))

;;; packages.el ends here
