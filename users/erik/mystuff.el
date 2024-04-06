;; json-mode
(use-package json-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :mode (("\\.js\\'" . web-mode)
         ("\\.jsx\\'" .  web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.html\\'" . web-mode))
  :commands web-mode)

(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))

(add-hook 'web-mode-hook
          (lambda ()
;	    (enable-paredit-mode)
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))
            (smartparens-mode)))

(use-package prettier-js
  :ensure t)

(add-hook 'web-mode-hook 'prettier-js-mode)


;; enable typescript - tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(use-package editorconfig)
(use-package ag)


(load-theme 'atom-dark t)
(when (window-system)
  (set-frame-font "-*-Monoid-light-normal-semicondensed-*-*-*-*-*-m-0-iso10646-1")
  (set-face-attribute 'default nil :height 110))

(use-package lsp-mode
  :ensure t
  :hook (
         (web-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
         )
  :commands lsp-deferred)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
(load-theme 'atom-dark)

(use-package projectile
  :init
  (setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))
  (setq projectile-globally-ignored-file-suffixes '("#~"))

  (setq projectile-keymap-prefix (kbd "C-c p"))
;  (setq projectile-completion-system 'ido)
  :config
  (projectile-global-mode))

(use-package fill-column-indicator
  :init
  (setq fci-rule-color "grey30")
  (setq fci-rule-column 80)
  (setq fci-handle-truncate-lines nil)
  :config
  (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
  (global-fci-mode 1))

(global-set-key (kbd "C-v") 'scroll-up-command)
(global-set-key (kbd "M-v") 'scroll-down-command)
(global-set-key (kbd "C-h") 'help-command)
(global-set-key (kbd "M-s") 'paredit-splice-sexp)
(global-set-key (kbd "C-x C-g") 'magit)
(define-key global-map (kbd "RET") 'newline-and-indent)

(line-number-mode t)
(global-display-line-numbers-mode 1)
(global-hl-line-mode nil)
(setq-default cursor-type 'bar)
(use-package ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(remove-hook 'clojure-mode-hook 'auto-refer-mode)
