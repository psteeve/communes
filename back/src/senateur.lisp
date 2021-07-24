(in-package :communes)

(defclass senateur ()
  ((description-profession :initarg :description-profession
                           :reader description-profession)
   (categorie-professionnelle :initarg :categorie-professionnelle
                              :reader categorie-professionnelle)
   (pcs-insee :initarg :pcs-insee
              :reader pcs-insee)
   (courrier-electronique :initarg :courrier-electronique
                          :reader courrier-electronique)
   (fonction-au-bureau-du-senat :initarg :fonction-au-bureau-du-senat
                                :reader fonction-au-bureau-du-senat)
   (circonscription :initarg :circonscription
                    :reader circonscription)
   (commission-permanente :initarg :commission-permanente
                          :reader commission-permanente)
   (type-d-app-au-grp-politique :initarg :type-d-app-au-grp-politique
                                :reader type-d-app-au-grp-politique)
   (groupe-politique :initarg :groupe-politique
                     :reader groupe-politique)
   (date-de-deces :initarg :date-de-deces
                  :reader date-de-deces)
   (date-naissance :initarg :date-naissance
                   :reader date-naissance)
   (etat :initarg :etat
         :reader etat)
   (prenom-usuel :initarg :prenom-usuel
                 :reader prenom-usuel)
   (nom-usuel :initarg :nom-usuel
              :reader nom-usuel)
   (qualite :initarg :qualite
            :reader qualite)
   (matricule :initarg :matricule
              :reader matricule)))

(defun make-senateur (sexp)
  (make-instance 'senateur
                 :description-profession (getf sexp :|Description_de_la_profession|)
                 :categorie-professionnelle (getf sexp :|Categorie_professionnelle|)
                 :pcs-insee (getf sexp :PCS_INSEE)
                 :courrier-electronique (getf sexp :|Courrier_electronique|)
                 :fonction-au-bureau-du-senat (getf sexp :|Fonction_au_Bureau_du_Senat|)
                 :circonscription (getf sexp :|Circonscription|)
                 :commission-permanente (getf sexp :|Commission_permanente|)
                 :type-d-app-au-grp-politique (getf sexp :|Type_d_app_au_grp_politique|)
                 :groupe-politique (getf sexp :|Groupe_politique|)
                 :date-de-deces (getf sexp :|Date_de_deces|)
                 :date-naissance (getf sexp :|Date_naissance|)
                 :etat (getf sexp :|Etat|)
                 :prenom-usuel (getf sexp :|Prenom_usuel|)
                 :nom-usuel (getf sexp :|Nom_usuel|)
                 :qualite (getf sexp :|Qualite|)
                 :matricule (getf sexp :|Matricule|)))

(defmethod print-object ((senateur senateur) stream)
  (with-slots (
               etat nom-usuel prenom-usuel
               circonscription)
      senateur
    (format stream
            "#<etat: ~a prenom-usuel: ~a
nom-usuel: ~a
            circonscription: ~a>"
            etat prenom-usuel nom-usuel circonscription)))

(defun make-senateurs (list)
  (mapcar #'make-senateur list))



