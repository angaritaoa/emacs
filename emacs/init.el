;;; -*- lexical-binding: t; -*-
;; #################################################################################################
;; fuentes
;; #################################################################################################
;; https://github.com/NapoleonWils0n/debian-dotfiles/blob/master/.config/emacs/init.el
;; https://gist.github.com/Ladicle

;; #################################################################################################
;; repos
;; #################################################################################################
(require 'package)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/") t))
(package-initialize)


;; #################################################################################################
;; use-package
;; #################################################################################################
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))


;; #################################################################################################
;; completion
;; #################################################################################################
(use-package vertico
  :ensure t
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 20)
  (vertico-resize nil)
  (vertico-cycle t)
  :init
  (vertico-mode)
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :bind (:map vertico-map
              ("DEL" . vertico-directory-delete-char)))

(use-package savehist
  :ensure t
  :init
  (savehist-mode))

(use-package emacs
  :custom
  (context-menu-mode t)
  (enable-recursive-minibuffers nil)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-ignore-case t))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

(use-package marginalia
  :ensure t
  :custom
  (marginalia-align 'left)
  :init
  (marginalia-mode))

(use-package consult
  :ensure t
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5
        xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult-source-bookmark consult-source-file-register
   consult-source-recent-file consult-source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"
        consult-project-function #'consult--default-project-function))

(use-package consult-todo
  :ensure t
  :after (consult hl-todo))

;;(use-package corfu
;;  :ensure t
;;  :custom
;;  (corfu-preview-current nil)
;;  (corfu-on-exact-match nil)
;;  (corfu-auto t)
;;  (corfu-auto-delay 0.0)
;;  (corfu-auto-prefix 1)
;;  (corfu-cycle t)
;;  (corfu-count 16)
;;  (corfu-max-width 120)
;;  (corfu-on-exact-match nil)
;;  (corfu-preselect ':prompt)
;;  (tab-always-indent 'complete)
;;  :bind (:map corfu-map
;;              ("RET" . #'corfu-insert)
;;              ("<return>" . #'corfu-insert))
;;  :init
;;  (global-corfu-mode))
;;
;;(use-package cape
;;  :ensure t
;;  :init
;;  (add-to-list 'completion-at-point-functions #'cape-file)
;;  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
;;  (add-to-list 'completion-at-point-functions #'cape-keyword)
;;  (add-to-list 'completion-at-point-functions #'cape-elisp-block))
(use-package company
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook (java-mode . lsp-deferred)
  :commands (lsp lsp-deferred)
  :config
  ;; Desactiva los Inlay Hints si te siguen molestando
  (setq lsp-eldoc-render-all nil)
  (setq lsp-signature-auto-activate nil)
  ;; Esto suele arreglar el texto extraño que mencionabas
  (setq lsp-completion-show-detail nil)
  (setq lsp-completion-show-kind nil))

(use-package lsp-java
  :ensure t
  :after lsp-mode)

(use-package nerd-icons
  :ensure t
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono"))

(use-package nerd-icons-corfu
  :ensure t
  :after (corfu nerd-icons)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))


;; #################################################################################################
;; ui
;; #################################################################################################
(use-package emacs
  :init
  (add-to-list 'default-frame-alist '(font . "JetBrains Mono-9.5"))
  (set-fontset-font t 'symbol "Symbols Nerd Font Mono" nil 'prepend))

(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures 'prog-mode
                          '("|||>" "<|||" "<==>" "=>" "==>" "===" "!==" "!!"
                            "||>" "<||" "-->" "->" "---" "-~" "-|" "/==" "/="
                            "///" "/**" "/*" "//" "|||" "<==" "==" "===" "==>"
                            "=>" "=~" "=>>" "=/" "=<<" "=/=" "!==" "!!" "||>"
                            "<||" "-->" "->" "---" "-~" "-|" "/==" "/=" "///"
                            "/**" "/*" "//" "|||" "<==" "==" "===" "==>" "=>"
                            "=~" "=>>" "=/" "=<<" "=/=" "!!" "??" "?." "?:"
                            "?=" "<<" "<<-" "<<=" "<=" "<=>" "<>" "<|" "<|-"
                            "<~" "<~>" "<~~" ">>>" ">>" ">>-" ">>=" ">=" ">=>"
                            ">>" ">-" ">=" ">=>" ">|" "||" "..." ".." ".="
                            ".-" "..<" "..." ".." ".=" ".-" "..<" "::" ":::"
                            ":=" "::=" ":?" ":?>" "//" "///" "/*" "*/" "/="
                            "//=" "/==" "@_" "__" "???" ";;" ";;;" "www"))
  (global-ligature-mode t))

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode t)
  :custom
  (doom-modeline-bar-width 3)
  (doom-modeline-icon t)
  (doom-modeline-minor-modes nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-buffer-file-name-style 'relative-from-project)
  (doom-modeline-buffer-encoding t)
  (doom-modeline-vcs-icon t)
  (doom-modeline-modal t)
  (doom-modeline-modal-icon t)
  (doom-modeline-modal-modern-icon t)
  :config
  (column-number-mode t)
  (size-indication-mode t))

(use-package hl-todo
  :ensure t
  :hook (prog-mode . hl-todo-mode))

(use-package diff-hl
  :ensure t
  :hook
  (diff-hl-mode . diff-hl-flydiff-mode)
  (magit-pre-refresh  . diff-hl-magit-pre-refresh)
  (magit-post-refresh . diff-hl-magit-post-refresh)
  :init
  (fringe-mode '(4 . 0))
  (global-diff-hl-mode)
  :config
  (setq diff-hl-update-async t
        diff-hl-global-modes '(not image-mode pdf-view-mode)
        vc-git-diff-switches '("--histogram")
        diff-hl-flydiff-delay 0.2
        diff-hl-show-staged-changes nil))

(use-package switch-window
  :ensure t
  :custom
  (switch-window-shortcut-style 'qwerty)
  (switch-window-threshold 2))

(use-package perspective
  :ensure t
  :init
  (setq persp-suppress-no-prefix-key-warning t)
  (persp-mode)
  :config
  (consult-customize consult-source-buffer :hidden t :default nil)
  (add-to-list 'consult-buffer-sources persp-consult-source)
  (setq persp-show-modestring nil)
  (setq switch-to-prev-buffer-skip
        (lambda (win buff bury-or-kill)
          (not (persp-is-current-buffer buff)))))

(use-package projectile
  :ensure t
  :init
  (projectile-mode t)
  :config
  (setq projectile-auto-discover t
        projectile-auto-cleanup-known-projects nil
        projectile-indexing-method 'alien
        projectile-enable-caching t))

(use-package persp-projectile
  :ensure t
  :after (perspective projectile))


;; #################################################################################################
;; keymaps
;; #################################################################################################
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 1.0
        which-key-allow-evil-operators t
        which-key-popup-type 'side-window
        which-key-side-window-location 'bottom
        which-key-side-window-max-height 0.5
        which-key-sort-order 'which-key-key-order
        which-key-max-display-columns 4
        which-key-separator " → "
        which-key-prefix-prefix nil))

(use-package general
  :ensure t
  :config
  (general-def
    :keymaps 'vertico-map
    "<escape>" #'abort-recursive-edit)

  (general-create-definer leader-def
    :prefix "<SPC>")

  (leader-def
    :states 'motion ;; equivale a: normal visual operator
    :keymaps 'override
    "" nil ;; Para que no haga nada si solo presionas SPC
    ;; general -----------------------------------------------------------------------------------------
    ";"  '(execute-extended-command :which-key "M-x command")
    ;; project -----------------------------------------------------------------------------------------
    "p"  '(:ignore t                        :which-key "Project")
    "pp" '(projectile-persp-switch-project  :which-key "Open known project")
    "pa" '(projectile-add-known-project     :which-key "Add new project")
    "pd" '(projectile-remove-known-project  :which-key "Remove known project")
    "pb" '(projectile-switch-to-buffer      :which-key "Switch to project buffer")
    "pf" '(projectile-find-file             :which-key "Switch to project file")
    "pi" '(projectile-invalidate-cache      :which-key "Invalidate project cache")
    "pk" '(projectile-kill-buffers          :which-key "Kill project buffers")
    "ps" '(projectile-save-project-buffers  :which-key "Save project buffers")
    ;; workspace ---------------------------------------------------------------------------------------
    "<TAB>"  '(:ignore t                    :which-key "Workspace")
    "<TAB>." '(persp-switch                 :which-key "Switch workspace")
    "<TAB>N" '(persp-switch                 :which-key "New workspace")
    "<TAB>k" '(persp-remove-buffer          :which-key "Remove buffer workspace")
    "<TAB>K" '(persp-kill                   :which-key "Kill workspace")
    "<TAB>r" '(persp-rename                 :which-key "Rename workspace")
    "<TAB>a" '(persp-add-buffer             :which-key "Add buffer to workspace")
    "<TAB>A" '(persp-set-buffer             :which-key "Set buffer to workspace")
    "<TAB>b" '(persp-switch-to-buffer*      :which-key "Switch buffer*")
    "<TAB>B" '(persp-switch-to-buffer       :which-key "Switch buffer")
    "<TAB>n" '(persp-next                   :which-key "Next workspace")
    "<TAB>p" '(persp-prev                   :which-key "Previous workspace")
    "<TAB>s" '(persp-state-save             :which-key "Save workspace to a file")
    "<TAB>l" '(persp-state-load             :which-key "Load workspace of a file")
    ;; file --------------------------------------------------------------------------------------------
    "f"  '(:ignore t                    :which-key "File")
    "ff" '(find-file                    :which-key "Find file")
    ;; buffer ------------------------------------------------------------------------------------------
    "b"  '(:ignore t               :which-key "Buffer")
    "bs" '(save-buffer             :which-key "Save buffer")
    "bn" '(next-buffer             :which-key "Next buffer")
    "bp" '(previous-buffer         :which-key "Previous buffer")
    "bb" '(consult-buffer          :which-key "Switch buffer*")
    "bB" '(persp-switch-to-buffer  :which-key "Switch buffer")
    "bd" '(kill-current-buffer     :which-key "Kill buffer")
    "bN" '(evil-buffer-new         :which-key "New empty buffer")
    "bR" '(rename-buffer           :which-key "Rename buffer")
    "bS" '(evil-write-all          :which-key "Save all buffers")
    ;; search ------------------------------------------------------------------------------------------
    "s"  '(:ignore t           :which-key "Search")
    "sb" '(consult-line        :which-key "Search buffer")
    "sm" '(consult-man         :which-key "Search manpages")
    "si" '(consult-info        :which-key "Search info")
    ;; evil-mc -----------------------------------------------------------------------------------------
    "m"  '(:ignore t                                   :which-key "Cursor")
    "mI" '(evil-mc-make-cursor-in-visual-selection-beg :which-key "Cursor beg")
    "mA" '(evil-mc-make-cursor-in-visual-selection-end :which-key "Cursor end")
    "me" '(evil-mc-undo-all-cursors                    :which-key "Cancel")
    ;; jump --------------------------------------------------------------------------------------------
    "j"  '(:ignore t              :which-key "Jump")
    "jw" '(avy-goto-char-timer    :which-key "Jump word")
    "jl" '(consult-goto-line      :which-key "Jump line")
    ;; window ------------------------------------------------------------------------------------------
    "w"  '(:ignore t              :which-key "Window")
    "ww" '(switch-window          :which-key "Switch window")
    "wd" '(delete-window          :which-key "Kill window")
    "wo" '(delete-other-windows   :which-key "Kill other")
    "ws" '(split-window-below     :which-key "Split -")
    "wv" '(split-window-right     :which-key "Split |")
    "wh" '(evil-window-left       :which-key "Window left")
    "wj" '(evil-window-down       :which-key "Window down")
    "wk" '(evil-window-up         :which-key "Window up")
    "wl" '(evil-window-right      :which-key "Window right")
    ;; eval --------------------------------------------------------------------------------------------
    "e"  '(:ignore t              :which-key "Eval")
    "ed" '(eval-defun             :which-key "Eval defun")
    "eb" '(eval-buffer            :which-key "Eval buffer")
    "er" '(eval-region            :which-key "Eval region")
    ;; todo --------------------------------------------------------------------------------------------
    "t"  '(:ignore t              :which-key "Todo")
    "tb" '(consult-todo           :which-key "Todo in buffer")
    "tp" '(consult-todo-project   :which-key "Todo in project")
    ;; git ---------------------------------------------------------------------------------------------
    "g"  '(:ignore t              :which-key "Git")
    "gg" '(magit-status           :which-key "Status")
    ;; eglot--------------------------------------------------------------------------------------------
    "c"  '(:ignore t              :which-key "Code")
    "cr" '(eglot-rename           :which-key "Rename symbol")
    "cf" '(eglot-format-buffer    :which-key "Format buffer")
    "ca" '(eglot-code-actions     :which-key "Code actions")
    ;; help --------------------------------------------------------------------------------------------
    "h"  '(:ignore t              :which-key "Help")
    "hm" '(describe-mode          :which-key "Describe mode")
    "hc" '(describe-command       :which-key "Describe command")
    "hv" '(describe-variable      :which-key "Describe variable")
    "hk" '(describe-keymap        :which-key "Describe keymap"))

  (general-auto-unbind-keys))


;; #################################################################################################
;; tools
;; #################################################################################################
(use-package treesit
  :ensure nil
  :config
  (setq treesit-font-lock-level 4))

(use-package magit
  :ensure t
  :init
  (setq magit-diff-refine-hunk 'all))

;; TODO: Configurar debug


;; #################################################################################################
;; editor
;; #################################################################################################
(use-package emacs
  :init
  (setq-default indent-tabs-mode nil
                tab-width 2)
  :config
  (electric-pair-mode t))

;; Guia: https://github.com/noctuid/evil-guide
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :custom
  (evil-ex-search-vim-style-regexp t)
  (evil-symbol-word-search t)
  (evil-ex-visual-char-range t)
  (evil-ex-interactive-search-highlight 'selected-window)
  (evil-mode-line-format 'nil)
  (evil-undo-system 'undo-redo)
  :config
  (evil-select-search-module 'evil-search-module 'evil-search)
  (evil-mode t))

(use-package evil-multiedit
  :ensure t
  :after evil
  :config
  (evil-multiedit-default-keybinds))

(use-package evil-mc
  :ensure t
  :after evil
  :config
  (setq evil-mc-undo-cursors-on-keyboard-quit t)
  (global-evil-mc-mode t))

(use-package avy
  :ensure t
  :config
  (setq avy-background t
        avy-all-windows nil))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))


;; #################################################################################################
;; lang
;; #################################################################################################
(use-package eglot-java :ensure t)

(use-package eglot
  :config
  (setq eglot-report-progress nil)
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider)
  ;;(setq eglot-inlay-hints-mode nil)
  ;;(setq-default eglot-inlay-hints-mode nil))
  :hook
  (eglot-managed-mode . (lambda () (eglot-inlay-hints-mode -1))))

(use-package prog-mode
  :ensure nil
  :init
  (setq display-line-numbers-type t)
  :hook
  (prog-mode . display-line-numbers-mode)
  (text-mode . display-line-numbers-mode)
  (before-save . whitespace-cleanup))

(use-package emacs
  :ensure nil
  :hook
  (emacs-lisp-mode . (lambda () (setq mode-name "Elisp")))
  (makefile-gmake-mode . (lambda () (setq mode-name "Makefile"))))

(use-package c++-ts-mode
  :ensure nil
  :init
  (add-to-list 'major-mode-remap-alist
               '((c-mode . c-ts-mode)
                 (c++-mode . c++-ts-mode)
                 (c-or-c++-mode . c-or-c++-ts-mode)))
  :config
  (setq c-ts-mode-indent-offset 2)
  :hook
  (c++-ts-mode . eglot-ensure))

(use-package java-ts-mode
  :ensure nil
  :init
  (add-to-list 'major-mode-remap-alist
               '(java-mode . java-ts-mode))
  :config
  (setq java-ts-mode-indent-offset 2)
  :hook
  (java-ts-mode . eglot-java-mode))

(use-package json-ts-mode
  :ensure nil
  :init
  (add-to-list 'major-mode-remap-alist
               '(json-mode . json-ts-mode)))
