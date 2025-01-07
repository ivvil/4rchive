;;;; 4rchive.asd

(asdf:defsystem #:4rchive
  :description "Archive 4chan threads"
  :author "Iván Villagrasa <ivvil412@gmail.com>"
  :license  "GPL-v3"
  :version "0.0.1"
  :serial t
  :depends-on (:dexador
			   :com.inuoe.jzon
			   :clingon)
  :components ((:file "package")
               (:file "4rchive")
			   (:file "org")
			   (:file "cli"))
  :build-operation "program-op"
  :build-pathname "4rchive"
  :entry-point "dev.shft.4rchive::main")
