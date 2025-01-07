LISP ?= sbcl

build:
	$(LISP) --load 4rchive.asd \
			--eval '(ql:quickload :4rchive)' \
			--eval '(asdf:make :4rchive)' \
			--eval '(quit)'
