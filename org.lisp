;;;; org.lisp

(in-package #:dev.shft.4rchive)

(defclass post ()
  ((id :initarg :id
	   :accessor id)
   (text :initarg :text
		 :accessor text)
   (time :initarg :time
		 :accessor time-posted)
   (subject :initarg :subject
			:accessor subject)
   (replies :initarg :replies
			:accessor replies)))

(defclass image ()
  ((image-id :initarg :image-id
			 :accessor image-id)
   (file :initarg :file
		 :accessor file)
   (extension :initarg :extension
			  :accessor extension)
   (img-folder :initarg :img-folder
			   :accessor img-folder)))

(defclass image-post (post image) ())

(defgeneric generate (post))

(defmethod generate ((post post))
  (format nil "* ~a~T:~a:~%:PROPERTIES:~%:ID: ~a~%:TIME: ~a~%:END:~%~%~a~%** Responses~&~{~a~^~%~}"
		  (or (subject post) (id post))
		  (id post)
		  (id post)
		  (time-posted post)
		  (or (text post) "")
		  (replies post)))

(defmethod generate ((post image-post))
  (let* ((post-text (call-next-method))
		(img (format nil "#+CAPTION: ~a~%[[~a]]" (file post) (get-image-file post)))
		(pos (+ 6 (search ":END:" post-text))))
	(add-to-string pos post-text img)))

(defgeneric get-image-file (post))

(defmethod get-image-file ((post image))
  (merge-pathnames (img-folder post) (make-pathname :name (file post) :type (extension post))))

(defun add-to-string (pos string1 string2)
  (let ((prev (subseq string1 0 pos))
		(post (subseq string1 pos)))
	(concatenate 'string prev string2 post)))
