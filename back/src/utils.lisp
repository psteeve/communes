(in-package :communes)


(defun copy-front-assets (dirname)
  (ensure-directories-exist *front-directory*)
  (pathname:walk-directory
   dirname
   (lambda (pathname)
     (if (pathname:directory-pathname-p pathname)
         (copy-front-assets pathname))
     (cl-fad:copy-file pathname
                       (format nil "~a~a"
                               *front-directory*
                               (format nil "~a"
                                       (pathname:file-name pathname)))
                       :overwrite t))))
