;;;; cli.lisp

(in-package #:dev.shft.4rchive)

(defun cli/options ()
  (list
   (clingon:make-option
	:flag
	:description "Short help"
	:short-name #\h
	:key :help)
   (clingon:make-option
	:string
	:description "Url to download"
	:short-name #\u
	:long-name "url"
	:key :url)))

(defun cli/top-level ()
  (clingon:make-command
   :name "4rchive"
   :description "Archive 4chan threads"
   :version "0.0.1"
   :authors '("Iván Villagrasa <ivvil412@gmail.com>")
   :options (cli/options)
   :handler #'cli/handler))

(defun cli/handler (cmd)
  (format t "URL: ~a~%" (clingon:getopt cmd :url)))

(defun main ()
  (clingon:run (cli/top-level)))
