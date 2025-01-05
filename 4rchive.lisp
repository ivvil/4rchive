;;;; 4chive.lisp

(in-package #:dev.shft.4rchive)

(defun get-thread-json (board-id thread-id)
  (dex:get (format nil "https://a.4cdn.org/~a/thread/~a.json" board-id thread-id)))

(defun get-posts (board-id thread-id)
  (let* ((text (get-thread-json board-id thread-id))
		(json (jzon:parse text)))
	(gethash "posts" json)))

(defun get-image (board-id tim extension)
  (dex:get (format nil "https://i.4cdn.org/~a/~a.~a" board-id tim extension)))

(defun download-image (board-id tim extension name location)
  (let ((image (get-image board-id tim extension))
		(filename (make-pathname :name name :type extension)))
	(with-open-file (f (merge-pathnames location filename) :direction :output
														   :element-type '(unsigned-byte 8)
														   :if-exists :supersede
														   :if-does-not-exist :create)
	  (write-sequence image f))))

(defun download-post-image (board-id post location)
  (let ((tim (gethash "tim" post))
		(extension (subseq (gethash "ext" post) 1))
		(name (gethash "filename" post)))
	(download-image board-id tim extension name location)))

(defun post-has-image-p (post)
  (flet ((has-hash-p (map key)
		   (nth-value 1 (gethash key map))))
	(and (has-hash-p post "tim")
		 (has-hash-p post "ext")
		 (has-hash-p post "filename"))))

(defun download-thread-images (board-id thread-id location)
  (let ((posts (get-posts board-id thread-id)))
	(dotimes (i (length posts))
	  (let ((post (aref posts i)))
		(when (post-has-image-p post)
		  (download-post-image board-id post location))))))

