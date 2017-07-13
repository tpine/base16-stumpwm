;;;; stumpwm-base16.lisp

(in-package #:stumpwm-base16)

(export '(load-theme
	  select-theme))

(stumpwm:defcommand load-theme (scheme &optional (scheme-dir nil)) ((:string "Scheme: ") (:type nil))
  "Load the specified base16 theme into StumpWM.
Optionally specify scheme-dir.
If scheme-dir is nil the scheme-dir is assumed to be the first portion of scheme before a '-' or the scheme name
As not all schemes follow this format sometimes the scheme-dir will need to be specified."
  ;; First set scheme-dir
  (flet ((set-scheme-dir (dir)
	   (merge-pathnames (concatenate 'string
					 "schemes/"
					 dir
					 "/")
			    cl-base16:*source-dir*)))
    (setf scheme-dir (if (not scheme-dir)
			 
			 ;; Special case where this does not work
			 (if (equal "cave-light" scheme)
			     ;; Return cave-light
			     (set-scheme-dir "cave-light")
			     ;; Otherwise Rip out the part which appears to be the scheme-dir
			     (if (position #\- scheme :test #'equalp)
				 ;; Check if this is a valid path

				 (let ((path-to-test (set-scheme-dir (subseq scheme 0 (position #\- scheme :test #'equalp)))))
				   (if (directory path-to-test)
				       ;; Return path-to-test
				       path-to-test))
				 ;; If there is not a '-' in the scheme we can assume it is the default scheme with the same pathname
				 (set-scheme-dir scheme)))
			 (set-scheme-dir scheme-dir))))

  (eval (read-from-string (cl-base16:apply-scheme (merge-pathnames (concatenate 'string
										scheme
										".yaml") scheme-dir)
						  "stumpwm" "default"))))

(stumpwm:defcommand select-theme () ()
  "Displays a menu allowing the browsing of schemes to apply."
  (let ((menu nil)
	(continue t))
    (loop while continue
	  do (maphash (lambda (key value)
			(declare (ignore value))
			(setf menu (append menu (list key))))
		      (yaml:parse (merge-pathnames "schemes/list.yaml" cl-base16:*source-dir*)))
	     (let ((scheme-dir (stumpwm:select-from-menu (stumpwm:current-screen) menu)))
	       (if (eq scheme-dir nil)
		   (setf continue nil)
		   (progn
		     (setf menu (list ".."))
		     (mapc (lambda (scheme)
			     (setf menu (append menu (list (uiop:split-name-type (file-namestring scheme))))))
			   (directory (merge-pathnames (concatenate 'string "schemes/" scheme-dir "/*.yaml") cl-base16:*source-dir*)))
		     (let ((selection (stumpwm:select-from-menu (stumpwm:current-screen) menu)))
		       (if (eq selection nil)
			   (setf continue nil)
			   (if (not (equal selection ".."))
			       (progn
				 (setf continue nil)
				 (format t "~a" (pathname-directory scheme-dir))
				 (load-theme selection scheme-dir)))))))))))
