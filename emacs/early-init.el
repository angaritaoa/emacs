;;; -*- lexical-binding: nil; -*-
(setq package-enable-at-startup nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
;;(push '(undecorated . t) default-frame-alist)

(setq inhibit-startup-message t)
(setq frame-resize-pixelwise t)
(setq frame-inhibit-implied-resize t)
(setq package-native-compile t)
(setq native-comp-speed 2)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

(setq gc-cons-threshold (* 10 128 1024 1024))
(setq garbage-collection-messages nil)

(setq read-process-output-max (* 8 1024 1024))

(setq ring-bell-function 'ignore)

(setq default-directory "~/")
(setq command-line-default-directory "~/")

(setq initial-scratch-message nil)
(setq initial-major-mode 'fundamental-mode)

(setq inhibit-compacting-font-caches t)

(setq history-delete-duplicates t)

(setq vc-follow-symlinks t)

(setq byte-compile-warnings '(cl-functions))

(setq native-comp-async-report-warnings-errors nil)
(setq comp-async-report-warnings-errors nil)
(setq native-comp-async-query-on-exit t)
(setq comp-async-query-on-exit t)

(setq user-full-name       "Andres Angarita"
      user-real-login-name "Andres Angarita"
      user-login-name      "angaritaoa"
      user-mail-address    "angaritaoa@gmail.com")
