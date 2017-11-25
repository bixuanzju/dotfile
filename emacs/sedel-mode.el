;;; SEDEL-mode --- A major mode for editing SEDEL files


;; Heavily copied from https://github.com/david-christiansen/frank.el
(require 'font-lock)

(defgroup sedel '() "The SEDEL language" :group 'languages)

(defface sedel-keyword-face
  '((t (:inherit 'font-lock-keyword-face)))
  "How to highlight SEDEL's keywords"
  :group 'sedel)

(defface sedel-operator-face
  '((t (:inherit 'font-lock-builtin-face)))
  "How to highlight SEDEL operators"
  :group 'sedel)

(defface sedel-type-face
  '((t (:inherit 'font-lock-type-face)))
  "How to highlight SEDEL type variables"
  :group 'sedel)

(defface sedel-definition-face
  '((t (:inherit 'font-lock-function-name-face)))
  "How to highlight SEDEL names in their definitions"
  :group 'sedel)

(defconst sedel-keywords
  '("override" "letrec" "def" "defrec" "type" "inherits" "forall" "if" "then" "else" "let" "in" "new" "trait" "main"))

(defun sedel--current-line-empty-p ()
  "Non-nil if the current line is empty."
  (string-match-p "^\\s-*$" (thing-at-point 'line))  )

(defun sedel--current-line-indentation ()
  "Nil if the current line is empty, or the number of spaces at the beginning of the line."
  (let ((line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
    (if (string-match-p "^\\s-*$" line)
        nil
      (string-match (rx bol
                        (group-n 1 (zero-or-more ?\ ))
                        (not (any ?\ )))
                    line)
      (length (match-string-no-properties 1 line)))))

(defun sedel--next-non-indent ()
  "Find position before the next line that outdents.
The current line must be non-empty."
  (save-excursion
    (beginning-of-line)
    (let ((i (sedel--current-line-indentation)))
      (when (not i) (error "Current line empty"))
      (forward-line)
      (while (let ((j (sedel--current-line-indentation)))
               (and (not (eobp))
                    (or (not j)
                        (> j i))))
        (forward-line))
      (backward-char))
    (point)))


(defun sedel--update-kw ()
  "Update kws."
  (setq sedel-font-lock-keywords
        `(

          ;; Operator syntax
          ;; (,(regexp-opt '(",," "->" "<" ">" ":" "|" "==" "[" "]" "/=" "++" "&&" "||" "," "&" ";" "*" "." "/\\") 'symbols) 0 'sedel-operator-face)

          ;; Ordinary keywords
          (,(regexp-opt sedel-keywords  'words) 0 'sedel-keyword-face)

          ;; Type variables
          ("\\<\\('?[[:upper:]][[:alnum:]_]*\\)\\>" 0 'sedel-type-face)
          )))


(defvar sedel-mode-map (make-sparse-keymap)
  "Keymap for SEDEL major mode.")

(defconst sedel-mode-syntax-table
  (let ((st (make-syntax-table)))

    ;; Matching parens
    (modify-syntax-entry ?\( "()" st)
    (modify-syntax-entry ?\) ")(" st)
    (modify-syntax-entry ?\[ "(]" st)
    (modify-syntax-entry ?\] ")[" st)

    ;; Matching {}, but with nested comments
    (modify-syntax-entry ?\{ "(} 1bn" st)
    (modify-syntax-entry ?\} "){ 4bn" st)
    (modify-syntax-entry ?\- "_ 123" st)
    (modify-syntax-entry ?\n ">" st)

    ;; ' and _ can be names
    (modify-syntax-entry ?' "w" st)
    (modify-syntax-entry ?_ "w" st)

    ;; Whitespace is whitespace
    (modify-syntax-entry ?\  " " st)
    (modify-syntax-entry ?\t " " st)

    ;; Strings
    (modify-syntax-entry ?\" "\"" st)
    (modify-syntax-entry ?\\ "/" st)

    st)
  "Syntax table for `sedel-mode'.")


(spacemacs/set-leader-keys-for-major-mode 'sedel-mode
  ;; Shorthands: rebind the standard evil-mode combinations to the local
  ;; leader for the keys not used as a prefix below.
  "r" 'quickrun)


(push '("*quickrun*" :position bottom :height 0.3)
      popwin:special-display-config)

(eval-after-load 'quickrun
  '(progn
     (quickrun-add-command "sedel"
       '((:command . "SEDEL-exe")
         (:exec . "%c %s")
         (:tempfile . nil)
         (:description . "Run SEDEL"))
       :mode 'sedel-mode)
     (define-key sedel-mode-map (kbd "C-c C-r") 'quickrun)))



;;;###autoload
(define-derived-mode sedel-mode prog-mode "SEDEL"
  "Major mode for the SEDEL language."
  :syntax-table sedel-mode-syntax-table
  (sedel--update-kw)
  (set (make-local-variable 'indent-tabs-mode) nil)
  (set (make-local-variable 'comment-start) "--")
  (setq font-lock-defaults '((sedel-font-lock-keywords) nil nil))

  (use-local-map sedel-mode-map))


;;;###autoload
(add-to-list 'auto-mode-alist '("\\.sl\\'" . sedel-mode))

(provide 'sedel-mode)
;;; sedel-mode.el ends here
