(defpackage :communes
  (:use
   :bknr.datastore
   :dexador
   :common-lisp
   :jonathan)
  (:export
   :start-server
   :stop-server
   :nom
   :maire
   :init)
  (:shadowing-import-from :common-lisp :get :delete))

(in-package :communes)

(defparameter *base-geo-api* "https://geo.api.gouv.fr")

(defparameter *list-communes* (format nil "~a/communes?fields=surface,codeDepartement,codeRegion,population" *base-geo-api*))

(defparameter *base-directory* (uiop:native-namestring "~/.france/communes/"))


(defparameter *communes-store* (uiop:native-namestring "~/.france/communes/communes-store/"))

(defparameter *server-port* 9341)

(defvar *api-communes* "/api/v1/communes")
(defvar *api-communes-html* "/api/v1/communes/html")

(defvar *front-directory* (format nil "~afront/" *base-directory*))

;; GET
;; ​/communes
;; Recherche des communes
;; GET
;; ​/communes​/{code}
;; Récupérer les informations concernant une commune
;; GET
;; ​/departements​/{code}​/communes
;; Renvoi les communes d'un département
;; Départements
;; GET
;; ​/departements
;; Recherche des départements
;; GET
;; ​/departements​/{code}
;; Récupérer les informations concernant un département
;; GET
;; ​/departements​/{code}​/communes
;; Renvoi les communes d'un département
;; GET
;; ​/regions​/{code}​/departements
;; Renvoi les départements d'une région
;; Régions
;; GET
;; ​/regions
;; Recherche des régions
;; GET
;; ​/regions​/{code}
;; Récupérer les informations concernant une région
;; GET
;; ​/regions​/{code}​/departements
;; Renvoi les départements d'une région
