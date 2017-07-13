;;;; stumpwm-base16.asd

(asdf:defsystem #:stumpwm-base16
  :description "Interface to cl-base16 to allow easy application of base16 themes to StumpWM"
  :author "Thomas Atkinson <thomas@pinegrove.io>"
  :license "MIT"
  :serial t
  :depends-on (:cl-base16
	       :stumpwm
	       :uiop)
  :components ((:file "package")
               (:file "stumpwm-base16")))

