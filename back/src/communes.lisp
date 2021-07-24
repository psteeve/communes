(in-package :communes)

(defclass city (bknr.datastore:store-object)
  ((population
    :initarg :population
    :initform 0
    :reader population)

   (codes-postaux
    :initarg :code-postaux
    :reader codes-postaux)

   (code-departement
    :initarg :code-departement
    :index-type bknr.indices:hash-index
    :index-reader city-by-code-departement
    :index-values all-code-departement
    :reader code-departement)

   (code
    :initarg :code
    :reader code)

   (code-region
    :initarg :code-region
    :reader code-region)

   (nom
    :initarg :nom
    :index-initargs (:test #'equal)
    :index-type bknr.indices:hash-index
    :index-reader city-by-nom
    :index-values all-cities
    :reader nom)

   (wikipedia-link
    :initarg wikipedia-link
    :reader wikipedia-link)

   (surface
    :initarg :surface
    :reader surface)

   (website
    :initarg :website
    :initform nil
    :reader website)

   (maire :initarg :maire
          :initform nil
          :reader maire))

  (:metaclass bknr.datastore:persistent-class))

(defmethod initialize-instance :after ((city city) &key)
  (with-slots (code code-departement
               code-region nom
               wikipedia-link surface)
      city
    (setf code (st-utils:as-keyword (string-downcase code)))
    (setf code-departement (st-utils:as-keyword (string-downcase code-departement)))
    (setf code-region (st-utils:as-keyword (string-downcase code-region)))
    (setf surface surface)
    (setf nom (string-downcase nom))
    (setf wikipedia-link (format nil "~a~a" "https://fr.wikipedia.org/wiki/" (string-downcase nom)))))

(defmethod %to-json ((city city))
  (with-slots (
               nom code-departement
               code-region code
               surface
               population wikipedia-link)
      city
    (with-object
      (write-key-value "nom" nom)
      (write-key-value "population" population)
      (write-key-value "codeRegion" code-region)
      (write-key-value "codeDepartement" code-departement)
      (write-key-value "wikipediaLink" wikipedia-link)
      (write-key-value "surface" surface)
      (write-key-value "code" code))))

(defmethod to-html ((city city))
  (with-slots (
               nom code-departement
               code-region code
               surface
               population wikipedia-link)
      city
    (with-object
      (write-key-value "nom" nom)
      (write-key-value "population" population)
      (write-key-value "codeRegion" code-region)
      (write-key-value "codeDepartement" code-departement)
      (write-key-value "wikipediaLink" wikipedia-link)
      (write-key-value "surface" surface)
      (write-key-value "code" code))))

(defun communes-to-html (cities)
  (cl-markup:markup
   (:ul
    (loop for city in cities
          collect (cl-markup:markup (:li
                                     (:span (nom city))
                                     (:span (population city))))))))

(defun -list-communes ()
  (mapcar #'(lambda (commune)
              (make-instance 'city
                             :nom (getf commune :|nom|)
                             :code (getf commune :|code|)
                             :code-region (getf commune :|codeRegion|)
                             :code-departement (getf commune :|codeDepartement|)
                             :code-postaux (getf commune :|codesPostaux|)
                             :surface (getf commune :|surface|)
                             :population (getf commune :|population|)))
          (jonathan:parse (dex:get *list-communes*))))

(defun communes ()
  (all-cities))

(defun name-contains (item)
  (remove-if-not (lambda (commune)
                   (str:containsp item (nom commune)))
                 (communes)))

(defun city-of-more-than (population)
  (remove-if-not
   #'(lambda (commune)
       (and (population commune)
            (> (population commune) population)))
   (communes)))

(defun city-of-less-than (population)
  (remove-if-not
   #'(lambda (commune)
       (and (population commune)
            (< (population commune) population)))
   (communes)))

(defun code-departements ()
  (let ((deps nil))
    (loop for city in (communes)
          when (not (equal (code-departement city) :|nil|))
            do
               (setf deps (adjoin (code-departement city) deps)))
    deps))

(defmethod print-object ((city city) stream)
  (with-slots (
               nom population
               maire code-departement
               website)
      city
    (format stream
            "#<nom: ~a population: ~a
:maire ~a
            code-departement: ~a website: ~a>"
            nom population maire code-departement website)))
