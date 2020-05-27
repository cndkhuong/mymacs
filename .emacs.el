;; Load package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Load `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
;;(require 'diminish)
(require 'bind-key)

(setq use-package-always-ensure t)

;; Display line number when programming
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%4d \u2502")

;;Set tab index
(setq tab-width 4)

;; Display paren (highlight matching brackets)
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Change font
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 100
                    :weight 'normal
                    :width 'normal)

;;Icons
(use-package all-the-icons)

;; Display a directory tree view on the left side
(use-package neotree
 :config (progn
	  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
 :bind ("<f8>" . neotree-toggle))

;; NyanCat on Modeline as an analog indicator of your position in the buffer
(use-package nyan-mode
  :config
  (nyan-mode)
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck yasnippet company counsel nyan-mode neotree all-the-icons use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Break words
(global-visual-line-mode t)

;; Replace default completion frontend with Ivy
;; https://github.com/abo-abo/swiper
(use-package counsel
  :config (ivy-mode 1)
  :init
  (progn
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))
  )

;; Autocomplete
(use-package company
  :config (global-company-mode t))

;; Snippets
(use-package yasnippet
  :defer t
  :init
  (yas-global-mode 1))

;;;; FLYCHECK  - REALTIME ERROR CHECKING ===============
(use-package flycheck
  :config
  (global-flycheck-mode)
  (setq flycheck-check-syntax-automatically '(mode-enabled save))
  )

;;Comment on Ctr+c c
(defun xah-comment-dwim ()
  "Like `comment-dwim', but toggle comment if cursor is not at end of line."
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let ((-lbp (line-beginning-position))
          (-lep (line-end-position)))
      (if (eq -lbp -lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) -lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region -lbp -lep)
            (forward-line )))))))
(global-set-key (kbd "C-c c") 'xah-comment-dwim)

;; Move between windows
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)



;; Resize windows
(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)
