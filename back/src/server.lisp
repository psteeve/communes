(in-package :communes)

(defvar *document-root* *front-directory*)

(defvar *server* (make-instance 'hunchentoot:easy-acceptor
                                :document-root *document-root*
                                :port *server-port*))
(defun start-server ()
  (hunchentoot:start *server*))

(defun stop-server ()
  (hunchentoot:stop *server*))
