(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(setq load-path
      (append '("~/.emacs.d/packages")
              load-path))



;; https://qiita.com/blue0513/items/ff8b5822701aeb2e9aae
;; package管理
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; cmdキーを superとして割り当てる
(setq mac-command-modifier 'super)

;; バックスペースの設定
(global-set-key (kbd "C-h") 'delete-backward-char)

;; auto-complete（自動補完）
(require 'auto-complete-config)
(global-auto-complete-mode 0.5)

;; font
(add-to-list 'default-frame-alist '(font . "ricty-12"))

;; ;; color theme
;; (load-theme 'monokai t)

;; alpha
(if window-system
    (progn
      (set-frame-parameter nil 'alpha 95)))

;; ;; 非アクティブウィンドウの背景色を設定
;; (require 'hiwin)
;; (hiwin-activate)
;; (set-face-background 'hiwin-face "gray30")

;; line numberの表示
(require 'linum)
(global-linum-mode 1)

;; tabサイズ
(setq default-tab-width 4)

(if (functionp 'menu-bar-mode)
    ;; メニューバーを非表示
    (menu-bar-mode 0))

(if (functionp 'tool-bar-mode)
    ;; ツールバーを非表示
    (tool-bar-mode 0))

;; default scroll bar消去
(setq scroll-bar-mode t)

;; 現在ポイントがある関数名をモードラインに表示
(which-function-mode 1)

;; 対応する括弧をハイライト
(show-paren-mode 1)

;; リージョンのハイライト
(transient-mark-mode 1)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

;;current directory 表示
(let ((ls (member 'mode-line-buffer-identification
                  mode-line-format)))
  (setcdr ls
    (cons '(:eval (concat " ("
            (abbreviate-file-name default-directory)
            ")"))
            (cdr ls))))

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message 1)

;; ターミナルで起動したときにメニューを表示しない
(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; ;; elscreen（上部タブ）
;; (require 'elscreen)
;; (elscreen-start)
;; (global-set-key (kbd "s-t") 'elscreen-create)
;; (global-set-key "\C-l" 'elscreen-next)
;; (global-set-key "\C-r" 'elscreen-previous)
;; (global-set-key (kbd "s-d") 'elscreen-kill)
;; (set-face-attribute 'elscreen-tab-background-face nil
;;                     :background "grey10"
;;                     :foreground "grey90")
;; (set-face-attribute 'elscreen-tab-control-face nil
;;                     :background "grey20"
;;                     :foreground "grey90")
;; (set-face-attribute 'elscreen-tab-current-screen-face nil
;;                     :background "grey20"
;;                     :foreground "grey90")
;; (set-face-attribute 'elscreen-tab-other-screen-face nil
;;                     :background "grey30"
;;                     :foreground "grey60")
;; ;;; [X]を表示しない
;; (setq elscreen-tab-display-kill-screen nil)
;; ;;; [<->]を表示しない
;; (setq elscreen-tab-display-control nil)
;; ;;; タブに表示させる内容を決定
;; (setq elscreen-buffer-to-nickname-alist
;;       '(("^dired-mode$" .
;;          (lambda ()
;;            (format "Dired(%s)" dired-directory)))
;;         ("^Info-mode$" .
;;          (lambda ()
;;            (format "Info(%s)" (file-name-nondirectory Info-current-file))))
;;         ("^mew-draft-mode$" .
;;          (lambda ()
;;            (format "Mew(%s)" (buffer-name (current-buffer)))))
;;         ("^mew-" . "Mew")
;;         ("^irchat-" . "IRChat")
;;         ("^liece-" . "Liece")
;;         ("^lookup-" . "Lookup")))
;; (setq elscreen-mode-to-nickname-alist
;;       '(("[Ss]hell" . "shell")
;;         ("compilation" . "compile")
;;         ("-telnet" . "telnet")
;;         ("dict" . "OnlineDict")
;;         ("*WL:Message*" . "Wanderlust")))

;; neotree（サイドバー）
(require 'neotree)
(global-set-key "\C-o" 'neotree-toggle)

;; スクロールは1行ごとに
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

;; スクロールの加速をやめる
(setq mouse-wheel-progressive-speed nil)

;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; golden ratio
(golden-ratio-mode 1)
(add-to-list 'golden-ratio-exclude-buffer-names " *NeoTree*")

;; active window move
(global-set-key (kbd "<C-left>")  'windmove-left)
(global-set-key (kbd "<C-down>")  'windmove-down)
(global-set-key (kbd "<C-up>")    'windmove-up)
(global-set-key (kbd "<C-right>") 'windmove-right)

;; 大文字・小文字を区別しない
(setq case-fold-search t)

;; ファイル名検索
(define-key global-map [(super i)] 'find-name-dired)

;; ファイル内検索（いらないメッセージは消去）
(define-key global-map [(super f)] 'rgrep)
;; rgrepのheader messageを消去
(defun delete-grep-header ()
  (save-excursion
    (with-current-buffer grep-last-buffer
      (goto-line 5)
      (narrow-to-region (point) (point-max)))))
(defadvice grep (after delete-grep-header activate) (delete-grep-header))
(defadvice rgrep (after delete-grep-header activate) (delete-grep-header))

;; rgrep時などに，新規にwindowを立ち上げる
(setq special-display-buffer-names '("*Help*" "*compilation*" "*interpretation*" "*grep*" ))

;; "grepバッファに切り替える"
(defun my-switch-grep-buffer()
  (interactive)
    (if (get-buffer "*grep*")
            (pop-to-buffer "*grep*")
      (message "No grep buffer")))
(global-set-key (kbd "s-e") 'my-switch-grep-buffer)

;; 履歴参照
(defmacro with-suppressed-message (&rest body)
  "Suppress new messages temporarily in the echo area and the `*Messages*' buffer while BODY is evaluated."
  (declare (indent 0))
  (let ((message-log-max nil))
    `(with-temp-message (or (current-message) "") ,@body)))
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 1000)            ;; recentf に保存するファイルの数
(setq recentf-exclude '(".recentf"))           ;; .recentf自体は含まない
(setq recentf-auto-cleanup 'never)             ;; 保存する内容を整理
(run-with-idle-timer 30 t '(lambda ()          ;; 30秒ごとに .recentf を保存
                             (with-suppressed-message (recentf-save-list))))
(require 'recentf-ext)
(define-key global-map [(super r)] 'recentf-open-files)

;; コメントアウト
;; 選択範囲
(global-set-key (kbd "s-;") 'comment-region)

;; コメントアウト
;; 一行
(defun one-line-comment ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (end-of-line)
    (comment-or-uncomment-region (region-beginning) (region-end))))
(global-set-key (kbd "s-/") 'one-line-comment)

;; 直前のバッファに戻る
(global-set-key (kbd "s-[") 'switch-to-prev-buffer)

;; 次のバッファに進む
(global-set-key (kbd "s-]") 'switch-to-next-buffer)

;; redo+
(require 'redo+)
(global-set-key (kbd "C-z") 'redo)
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; git-gutter-fringe
(global-git-gutter-mode 1)

;; magit
(global-set-key (kbd "C-c C-g") 'magit-diff-working-tree)

;; ファイル編集時に，bufferを再読込
(global-auto-revert-mode 1)

;; eshell + shell-pop
(setq shell-pop-shell-type '("eshell" "*eshell*" (lambda () (eshell))))
(global-set-key (kbd "C-c o") 'shell-pop)







;; https://qiita.com/yn01/items/b8d3dcb5be9078a6e27f

;; ;; 環境を日本語、UTF-8にする
;; (set-locale-environment nil)
;; (set-language-environment "Japanese")
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (setq default-buffer-file-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (prefer-coding-system 'utf-8)
;; 
;; ;; スタートアップメッセージを表示させない
;; (setq inhibit-startup-message t)
;; 
;; ;; バックアップファイルを作成させない
;; (setq make-backup-files nil)
;; 
;; ;; 終了時にオートセーブファイルを削除する
;; (setq delete-auto-save-files t)
;; 
;; ;; タブにスペースを使用する
;; (setq-default tab-width 4 indent-tabs-mode nil)
;; 
;; ;; 改行コードを表示する
;; (setq eol-mnemonic-dos "(CRLF)")
;; (setq eol-mnemonic-mac "(CR)")
;; (setq eol-mnemonic-unix "(LF)")
;; 
;; ;; 複数ウィンドウを禁止する
;; (setq ns-pop-up-frames nil)
;; 
;; ;; ウィンドウを透明にする
;; ;; アクティブウィンドウ／非アクティブウィンドウ（alphaの値で透明度を指定）
;; (add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))
;; 
;; ;; メニューバーを消す
;; (menu-bar-mode -1)
;; 
;; ;; ;; ツールバーを消す
;; ;; (tool-bar-mode -1)
;; 
;; ;; 列数を表示する
;; (column-number-mode t)
;; 
;; ;; 行数を表示する
;; (global-linum-mode t)
;; 
;; ;; カーソルの点滅をやめる
;; (blink-cursor-mode 0)
;; 
;; ;; カーソル行をハイライトする
;; (global-hl-line-mode t)
;; 
;; ;; 対応する括弧を光らせる
;; (show-paren-mode 1)
;; 
;; ;; ウィンドウ内に収まらないときだけ、カッコ内も光らせる
;; (setq show-paren-style 'mixed)
;; ;; (set-face-background 'show-paren-match-face "grey")
;; ;; (set-face-foreground 'show-paren-match-face "black")
;; 
;; ;; スペース、タブなどを可視化する
;; (global-whitespace-mode 1)
;; 
;; ;; スクロールは１行ごとに
;; (setq scroll-conservatively 1)
;; 
;; ;; シフト＋矢印で範囲選択
;; (setq pc-select-selection-keys-only t)
;; ;; (pc-selection-mode 0)
;; 
;; ;; C-kで行全体を削除する
;; (setq kill-whole-line t)
;; 
;; ;;; dired設定
;; (require 'dired-x)
;; 
;; ;; "yes or no" の選択を "y or n" にする
;; ;; (fset 'yes-or-no-p 'y-or-n-p)
;; 
;; ;; beep音を消す
;; (defun my-bell-function ()
;;   (unless (memq this-command
;;         '(isearch-abort abort-recursive-edit exit-minibuffer
;;               keyboard-quit mwheel-scroll down up next-line previous-line
;;               backward-char forward-char))
;;     (ding)))
;; (setq ring-bell-function 'my-bell-function)
;; 
;; ;; ;; Macのキーバインドを使う
;; ;; (mac-key-mode 1)
;; 
;; ;; Macのoptionをメタキーにする
;; (setq mac-option-modifier 'meta)
;; 
