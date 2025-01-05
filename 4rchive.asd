;;;; 4chive.asd

(asdf:defsystem #:4rchive
  :description "Describe 4chive here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:dexador
			   :com.inuoe.jzon)
  :components ((:file "package")
               (:file "4rchive")
			   (:file "org")))
