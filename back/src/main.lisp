(in-package :communes)

(defun init-data-store ()
  (when (or (not (boundp 'bknr.datastore:*store*)) (null bknr.datastore:*store*))
    (let ((object-subsystem (make-instance 'bknr.datastore:store-object-subsystem)))
      (make-instance 'bknr.datastore:mp-store
                     :directory *communes-store*
                     :subsystems (list object-subsystem)))))

(defun init ()
  (ensure-directories-exist *base-directory*)
  (init-data-store))
