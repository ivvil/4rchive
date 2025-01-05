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
  (format nil "* ~a~T:~a:~%:PROPERTIES:~%:ID: ~a~%:TIME: ~a~%:REPLIES: [[~a]]~%:END:~%~%~a~%"
		  (id post)
		  (id post)
		  (id post)
		  (time-posted post)
		  (replies post)
		  (or (text post) "")))

(defmethod generate ((post image-post))
  (let* ((post-text (call-next-method))
		 (img (format nil "#+CAPTION: ~a~%[[./~a]]" (file post) (get-image-file post)))
		 (pos (+ 6 (search ":END:" post-text))))
	(add-to-string pos post-text img)))

(defgeneric get-image-file (post))

(defmethod get-image-file ((post image))
  (merge-pathnames (img-folder post) (make-pathname :name (file post) :type (extension post))))

(defun add-to-string (pos string1 string2)
  (let ((prev (subseq string1 0 pos))
		(post (subseq string1 pos)))
	(concatenate 'string prev string2 post)))

(defun make-post (post)
  (make-instance 'post :id (gethash "no" post)
					   :text (gethash "com" post)	;TODO Translate html escaped characters
					   :time (gethash "time" post) ;TODO Translate it onto a timestamp
					   :replies (gethash "resto" post)))

(defun make-image-post (post image-folder)
  (make-instance 'image-post :id (gethash "no" post)
					   :text (gethash "com" post)	;TODO Translate html escaped characters
					   :time (gethash "time" post) ;TODO Translate it onto a timestamp
					   :replies (gethash "resto" post)
					   :image-id (gethash "tim" post)
					   :file (gethash "filename" post)
					   :extension (subseq (gethash "ext" post) 1)
					   :img-folder image-folder))

(defun get-org (posts)
  (apply #'concatenate 'string (map 'list #'generate posts)))


