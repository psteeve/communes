(in-package :communes)

(hunchentoot:define-easy-handler (communes-handler
                                  :uri *api-communes*)
    ((search :init-form ""))
  (setf (hunchentoot:content-type*) "application/json")
  (jonathan:to-json (name-contains (string-downcase search))))

(hunchentoot:define-easy-handler (communes-html-handler
                                  :uri *api-communes-html*)
    ((name :init-form ""))
  (setf (hunchentoot:content-type*) "text/html")
  (to-html (name-contains name)))
