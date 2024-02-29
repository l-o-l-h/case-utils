;;; case-utils.el -- Utility Files for Working With Cases -*- mode:elisp; lexical-binding: t; -*-
;;;
;;; Time-stamp: <2024-02-28 22:58:39 minilolh>

;;; Date: 2024-02-28

;;; Commentary:

;;; Code:

(defconst +lolh/my-drive+ (getenv "LH_MY_DRIVE"))
(defconst +lolh/my-cases-2022+ (getenv "LH_MY_CASES_2022"))
(defconst +lolh/my-cases-2023+ (getenv "LH_MY_CASES_2023"))
(defconst +lolh/my-cases-2024+ (getenv "LH_MY_CASES_2024"))


(defun lolh/calc-name (name)
  "Turn `John Adams Doe' into `DOE,J'

Also turn `John Doe' into `DOE,j'

- `NAME': is a string, and must containt at least a first and
last name, but may optionally include a middle name.  At this
time it cannot accommodate hyphenated names, degrees (Jr., Sr.)
or names with more than 3 parts.

TODO: refactor to take into account the many variations of name.
Can try `split-string', for example."

  (string-match "^\\([[:alpha:]]+\\)[[:space:]]\\(\\([[:alpha:]]+\\)[[:space:]]\\)?\\([[:alpha:]]+\\)$" name)

  (format "%s,%s" (upcase (match-string 4 name)) (match-string 1 name)))


(defun lolh/create-gd-file-name (cause name date title &optional name2)
  "Given some data, put together a case file name for the Google Drive.

INPUTS:
- `CAUSE': 24-2-12345-06
- `NAME': JOHN ADAMS DOE (required first client name)
- `NAME2': JANE AUSTIN DOE (optional second client name)
- `DATE': [2024-02-28 Wed]
- `TITLE' DEF Motion for OLD

RETURN:
- `CASE-FILE-NAME': 24-2-12345-06 [2024-02-28 Wed] DOE,J-DOE,M -- DEF Motion for OLD"

  (let ((f-name (lolh/calc-name name))
        (f-name2 (if name2 (lolh/calc-name name2) nil)))
    (format "%s %s %s-%s -- %s" cause date f-name f-name2 title)))


(provide 'lolh/case-utils)

;;; End case-utils
