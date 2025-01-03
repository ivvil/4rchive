;;;; 4chive.asd

(asdf:defsystem #:4chive
  :description "Describe 4chive here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:dexador)
  :components ((:file "package")
               (:file "4chive")))
