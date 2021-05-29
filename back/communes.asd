(asdf:defsystem :communes
  :serial t
  :components (
               (:file "src/config")
               (:file "src/server")
               (:file "src/handlers")
               (:file "src/communes")
               (:file "src/main")
               (:file "src/utils"))
               
  :depends-on (
               :st-utils
               :dexador :jonathan
               :str :pathname :cl-fad
               :cl-markup
               :bknr.datastore :hunchentoot))
