; BASE DE REGLES
(setq *BR* '(

    (R1 ((qualite courage) (sortilege Expelliarmus) (loisir quidditch)) (maison Gryffondor))
    (R2 ((qualite malice) (temperament intrepide) (loisir quidditch)) (maison Serpentard))
    (R3 ((valeur justice) (temperament travailleur) (default jalousie)) (maison Poufsouffle))
    (R4 ((valeur sagesse) (sortilege Legilimens)) (maison Serdaigle))
    (R5 ((valeur sagesse) (sortilege Herbivicus)) (maison Hagrid))

    (R6 ((boisson vin) (default arrogance)) (qualite malice))
    (R7 ((boisson biere) (default arrogance)) (qualite courage))

    (R8 ((type extraverti) (naturel adroit)) (sortilege Expelliarmus))
    (R9 ((type introverti) (default arrogance)) (sortilege Legilimens))
    (R10 ((type introverti) (milieu populaire)) (sortilege Herbivicus))

    (R11 ((milieu bourgeois)) (default arrogance))
    (R12 ((milieu populaire)) (default jalousie))

    (R13 ((naturel adroit)) (loisir quidditch))
    (R14 ((naturel curieux)) (loisir librairie))

    (R15 ((boisson vin) (naturel curieux)) (valeur justice))
    (R16 ((boisson biere) (loisir librairie)) (valeur sagesse))

    (R17 ((boisson vin) (type introverti)) (temperament travailleur))
    (R18 ((type extraverti) (milieu bourgeois)) (temperament intrepide))

    (R19 ((humeur joyeux) (amour fidele)) (boisson biere))
    (R20 ((humeur triste) (amour infidele)) (boisson vin))

    (R21 ((baguette chaine)) (amour fidele))
    (R22 ((baguette surreau)) (amour infidele))

))

; BASE DE FAITS
(setq *BF* nil)

; BASE DE BUTS (Utile pour le chainage arrière)
(setq *BB* nil)

; ETATS FINAUX
(setq *EF* '(
    (maison Gryffondor)
    (maison Serpentard)
    (maison Poufsouffle)
    (maison Serdaigle)
    (maison Hagrid)
))


; Pour construire nos moteurs ici, nous avons besoins de certaines fonctions intermédiaires

; -- PREMISSE D'UNE REGLE --
(defun premisse (idRegle)
  (cadr (assoc idRegle *BR*))
)

; -- BUT D'UNE REGLE --
(defun but (idRegle)
  (caddr (assoc idRegle *BR*))
)

; -- CUSTOM MEMBER -- La fonction member ne permet pas de vérifier qu'une liste est à l'intérieur d'une liste
(defun custom_member (item L)
  (let ((result nil))
  (dolist (x L result)
    (if (and (eq (car item) (car x)) (eq (cadr item) (cadr x))) ; eq ne nous permet pas de tester l'égalité des listes -> On suppose ici que tout nos items sont de la forme (car cadr)
     (setq result t))
  ))
)


; -- PRESENCE DES PREMISSES DANS LA BASE DE FAITS --
(defun presence_premisses_BF (premisses)
  (let ((presence t))
  (dolist (x premisses presence)
    (if (not (custom_member x *BF*)) (setq presence nil)) ; Si une des premisse n'est pas dans la BF alors on va renvoyer nil
  ))
)

; -- MOTEUR AVANT --

; -- REGLES CANDIDATES --
(defun regles_candidates_avant ()
  (let ((candidats nil))
  (dolist (regle *BR* candidats)
    (let ((idRegle (car regle)))
    (if (and (not (custom_member (but idRegle) *BF*)) (presence_premisses_BF (premisse idRegle))) ; La regle est candidate si les premisses sont dans la BF mais pas le but de la règle
      (push regle candidats))
    )
  ))
)

; -- UPDATE BASE DE FAITS --
(defun update_BF ()
  (dolist (x (regles_candidates_avant) nil)
    (if (not (custom_member (but x) *BF*))
    (push (but (car x)) *BF*)) ; Attention x est ici une règle, pour avoir son id il faut faire (car x)
  )
)

; -- RESULTATS CHOIXPEAUX --
(defun choix_choixpeaux ()
  (let ((choix nil))
  (dolist (x *BF* choix)
    (if (custom_member x *EF*)
      (push x choix))
  ))
)

; -- MOTEUR --
(defun moteur_avant ()
    (let ((choix (choix_choixpeaux)))
        (cond
            ((not (eq nil choix)) (format t "~%Pour vous ce sera ~A ! ~%" (car (cdar choix))))

            ; Si pas encore d'EF dans BF
            ((eq nil (regles_candidates_avant))
            ; Cas où le chapeux n'a pas de réponse -> L'élève ne peut pas intégrer Poudlard
            (format t "~%Vous ne pouvez pas intégrer Poudlard, rejoignez Voldemort ! ~%"))
            ; Sinon on rappelle le moteur
            (t (update_BF) (moteur_avant))
        )
    )
)

; -- MOTEUR ARRIERE --

(defun absence_premisses_BB (premisses)
  (let ((result nil))
    (dolist (x premisses result) ; ; parcours des prémisses de la règles
      (if (not (custom_member x *BB*)) ; vérification de leur présence dans la base de buts
        (setq result t)
      )
    )
  )
)

(defun regles_candidates_arriere ()
    (let ((candidats nil))
        (dolist (regle *BR* candidats) ; parcours des règles
            (let ((idRegle (car regle)))
                (if (and (absence_premisses_BB (premisse idRegle)) (custom_member (but idRegle) *BB*)) ; si un but est dans la BB mais une de ses premisses n'y est pas, on ajoute la règle aux candidats
                    (push idRegle candidats)
                )
            )
        )
    )
)

(defun update_BB (candidats)
    (dolist (x candidats) ; parcours des règles candidates
        (dolist (y (premisse x)) ; parcours des prémisses d'une règle candidate
            (if (not (custom_member y *BB*))
                (push y *BB*) ; mise à jour de la base de buts
            )
        )
    )
)

(defun bon_choix_arriere ()
  (let ((result t))
    (dolist (fait *BF* result) ; parcours des faits
      (if (not (custom_member fait *BB*))
        (setq result nil)
      )
    )
  )
)

(defun sousMoteur ()
    (if (not (null (bon_choix_arriere)))
        (format t "~%Vous avez fait le bon choix en choisissant la maison ~A. ~%" (cadr (car (last *BB*))))
        (let ((candidats (regles_candidates_arriere)))
            (cond ((not (null candidats))
                (update_BB candidats)
                (sousMoteur)
            ))
        )
    )
)

(defun moteur_arriere (maison)
    (let ((result nil))
        (setq *BB* nil)
        (push maison *BB*)
        (sousMoteur)
        (if (not (null (bon_choix_arriere)))
            (setq result t)
        )
        (if (null result)
            (format t "~%Votre intégration à ~A était une erreur... Utilisez le moteur avant pour savoir quelle maison vous correspond. ~%" (cadr maison))
        )
    )
)

; -- QUESTIONS

(setq *Questions*
      '((1 "En quelle bois est faite votre baguette ? " (surreau chaine) baguette)
        (2 "Etes-vous plutot de naturel curieux/intellectuel ou adroit/manuel ? " (curieux adroit) naturel)
        (3 "Etes-vous plutot introverti ou extraverti > " (introverti extraverti) type)
        (4 "Avez-vous grandi dans un milieu populaire ou bourgeois ? " (populaire bourgeois) milieu)
        (5 "Etes vous plus souvent d'humeur joyeuse ou maussade ? " (joyeux triste) humeur)
       )
)

(defun Ask_question () ; a refaire
    (let ((Q *Questions*))
        (setq *BF* ())
        (loop while (not (eq Q nil)) do
            (let* ((Question (car Q)) (rep T))
                (write (cadr Question))
                (write (caddr Question))
                (format T " ->")
                (setq rep (read))
                (push (list (cadddr (car Q)) rep) *BF*)
                (setq Q (cdr Q))
            )
        )
        *BF*
    )
)

; -- MENU --
(defun AffichageMenu()
    (Loop
        (format T "~%")
        (format T "|-----------------------------------------------------------------------------------|~%")
        (format T "|                                 Application Choixpeaux                            |~%")
        (format T "|-----------------------------------------------------------------------------------|~%")
        (format T "| Que souhaitez vous faire ?                                                        |~%")
        (format T "|  1 - [Chainage arrière] Savoir si mon ma maison actuelle a Poudlard me correspond.|~%")
        (format T "|  2 - [Chainage avant] Connaitre ma future maison a Poudlard.                      |~%")
        (format T "|-----------------------------------------------------------------------------------|~%")
        (format T "~%->")
        (let ((choice (read)))
            (cond
                ((or (< choice 1) (> choice 2)) (format T "~%Ce choix n'est pas valide. ~%"))
                ((eq choice 1) (progn
                    (format T "~%")
                    (format T "|-----------------------------------------------------------------------|~%")
                    (format T "| Veuillez sélectionner votre maison actuelle chez Poudlard :           |~%")
                    (format T "|  Gryffondor                                                           |~%")
                    (format T "|  Serpentard                                                           |~%")
                    (format T "|  Poufsouffle                                                          |~%")
                    (format T "|  Serdaigle                                                            |~%")
                    (format T "|  Hagrid                                                               |~%")
                    (format T "|-----------------------------------------------------------------------|~%")
                    (format T "->")
                    (setq choixMaison (read))
                        (loop while (not (or (eq choixMaison 'Gryffondor) (eq choixMaison 'Serpentard) (eq choixMaison 'Poufsouffle) (eq choixMaison 'Serdaigle) (eq choixMaison 'Hagrid))) do
                            (format T "~%")
                            (format T "-> Le choix est une des quatres maisons ou Hagrid.~%")
                            (format T "->")
                            (setq choixMaison (read))
                        )
                        (setq maison (list 'maison choixMaison)) ; Attention à mettre la valeur sous la forme (maison choix) pour utiliser le moteur arriere
                        (format T "~%-> Repondez aux questions qui vont suivre ci-dessous ~%~%")
                        (Ask_question)
                        (moteur_arriere maison)
                ))
                ((eq choice 2) (progn
                    (format T "~%-> Repondez aux questions qui vont suivre ci-dessous ~%~%")
                    (Ask_question)
                    (setq s (moteur_avant))
                    (format T "~%~%")
                ))
            )
        )
        (format T "~%")
        (format T "|----------------------------------------------------------------------------------|~%")
        (format T "| Voulez vous reiterer l'experience ? (Si oui saisissez OUI, si non saisissez NON) |~%")
        (format T "|----------------------------------------------------------------------------------|~%")
        (format T "->")
        (let ((x (read)))
            (cond
                ((EQUAL x 'OUI) (setq repeter 'yes))
                ((EQUAL x 'NON) (setq repeter NIL))
            )
            (when (not repeter)
                (return NIL)
            )
        )
    )
)

(AffichageMenu)
