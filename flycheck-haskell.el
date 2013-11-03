;;; flycheck-cask.el --- Cask support in Flycheck -*- lexical-binding: t; -*-

;; Copyright (C) 2013  Sebastian Wiesner

;; Author: Sebastian Wiesner <lunaryorn@gmail.com>
;; URL: https://github.com/flycheck/flycheck-cask
;; Keywords: tools, convenience
;; Version: 0.2-cvs
;; Package-Requires: ((flycheck "0.14") (dash "2.0.0") (f "0.6.0"))

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Add Cabal-Ghc support for Flycheck.

;;;; Setup

;; (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)

;;; Code:

(require 'flycheck)
(require 'dash)
(require 'haskell-cabal)

;; (defgroup flycheck-haskell nil
;;   "Haskell support for Flycheck."
;;   :prefix "flycheck-haskell-"
;;   :group 'flycheck
;;   :link '(url-link :tag "Github" "https://github.com/flycheck/flycheck-haskell"))

;; (defcustom flycheck-haskell-read-from-ghc-option-file t
;; "When non-nil, read the ghc options from a file .ghc-options.

;; If this variable is non nil, set the options from the file .ghc-options into
;; the variable `flycheck-haskell-options'."
;;   :group 'flycheck-haskell
;;   :type 'boolean)

;;;###autoload
(defun flycheck-haskell-setup ()
  "Setup Cabal/GHC integration for Flycheck.

If the current file is part of a Cabal project and there is a .ghc-options file,
as denoted by the existence of a Cabal and .ghc-options file in the file's
directory or any ancestor thereof, change to cabal directory and pass the
options in .ghc-options to hdevtools.

Set `flycheck-haskell-options-finder' accordingly."
  (setq flycheck-haskell-options-finder
	(eval '(ghc-options-finder)))
)

(defun ghc-options-finder ()
  "Change to cabal directory and return the options list found in .ghc-options.

Find a Cabal and a .ghc-options file in some superdirectory, change to the
directory of the Cabal file and read the ghc options into a list.
Returns this options list."
(when (buffer-file-name)
    (-when-let* ((file (haskell-cabal-find-file))
		 (cabal-dir (when file (file-name-directory file)))
		 (root-dir (locate-dominating-file (buffer-file-name) ".ghc-options"))
		 (ghc-options-file (concat root-dir ".ghc-options"))
		 (options-buffer (find-file-noselect ghc-options-file))
		 (ghc-options (with-current-buffer options-buffer
				(split-string (buffer-string))))
                 ;; (hdevtools-options
                 ;;  (mapcar (lambda (s) (concat "-g" s))  ghc-options))
		 )
      (cd cabal-dir)
      ;; (message "ghc options found: %S" ghc-options)
      ;; (message "hdevtools options found: %S" hdevtools-options)
      ghc-options
      )))

(provide 'flycheck-haskell)
;;; flycheck-haskell.el ends here
