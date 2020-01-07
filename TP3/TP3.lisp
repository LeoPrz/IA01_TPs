; BASE DE REGLES
(setq *BR* '(

  (R1 ((qualite courage) (temperament intrepide) (sport quidditch)) (maison Gryffondor))
  (R2 ((qualite malice) (sortilege Expelliarmus)) (maison Serpentard))
  (R3 ((valeur justice) (temperament travailleur)) (maison Poufsouffle))
  (R4 ((valeur sagesse) (sortilege Legilimens)) (maison Serdaigle))
  (R5 ((valeur sagesse) (sortilege Herbivicus)) (maison Hagrid))

  (R6 ((boisson vin) (default arrogance)) (qualite malice))
  (R7 ((boisson biere) (default arrogance)) (qualite courage))

  (R8 ((type extraverti) (default jalousie)) (sortilege Expelliarmus))
  (R9 ((type extraverti) (default arrogance)) (sortilege Legilimens))
  (R10 ((type introverti)) (sortilege Herbivicus))

  (R11 ((milieu bourgeois)) (default arrogance))
  (R12 ((milieu populaire)) (default jalousie))

  (R13 ((naturel adroit)) (sport quidditch))

  (R14 ((boisson vin) (naturel curieux)) (valeur justice))
  (R15 ((boisson biere) (milieu populaire) (sport quidditch)) (valeur sagesse))

  (R16 ((boisson vin) (type introverti)) (temperament travailleur))
  (R17 ((type extraverti) (milieu bourgeois)) (temperament intrepide))

  (R18 ((humeur joyeux) (amour fidele)) (boisson biere))
  (R19 ((humeur triste) (amour infidele)) (boisson vin))

  (R20 ((baguette chaine)) (amour fidele))
  (R21 ((baguette surreau)) (amour infidele))

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
))


; Pour construire nos moteurs ici, nous avons besoins de certaines fonctions intermédiaires

; -- PREMISSE D'UNE REGLE --
(defun premisses (idRegle)
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
  (let ((candidates nil))
  (dolist (regle *BR* candidates)
    (let ((idRegle (car regle)))
    (if (and (not (custom_member (but idRegle) *BF*)) (presence_premisses_BF (premisses idRegle))) ; La regle est candidate si les premisses sont dans la BF mais pas le but de la règle
      (push regle candidates))
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
  ((not (eq nil choix)) (format t "Pour vous ce sera ~A !" (car (cdar choix))))

  ; Si pas encore d'EF dans BF
  ((eq nil (regles_candidates_avant))
    ; Cas où le chapeux n'a pas de réponse -> L'élève ne peut pas intégrer Poudlard
    (format t "Vous ne pouvez pas intégrer Poudlard, rejoignez Voldemort !"))
  ; Sinon on rappelle le moteur
  (t (update_BF) (moteur_avant))
  ))
)

; -- MOTEUR ARRIERE --

(defun but_atteignable (b) ; Un but est atteignable si ses premisses sont dans la BB ou dans la BF
  (let ((atteignables t) (idRegle nil))
  (dolist (x *BR* nil)
    (if (eq (cadr (but (car x))) (cadr b)) ; On va chercher la règle qui correspond au but
      (setq idRegle (car x))) ; On sauvegarde son id
  )
  (dolist (x (premisses idRegle) atteignables) ; Pour chaque premisses de la règle concernant le but à atteindre
    (if (not (or (custom_member x *BF*)  (custom_member x *BF*)))
      (setq atteignables nil))
  ))
)

(defun bon_choix_maison (maison) ; Une maison est la bonne si ses premisses sont la BB
  (let ((atteignables t) (idRegle nil))
  (dolist (x *BR* nil)
    (if (eq (cadr (but (car x))) (cadr maison)) ; On va chercher la règle qui correspond à la maison
      (setq idRegle (car x))) ; On sauvegarde son id
  )
  (dolist (x (premisses idRegle) atteignables)
    (if (not (custom_member x *BB*))
      (setq atteignables nil))
  ))
)

(defun regles_candidates_arriere () ; Une règle est candidates arrière si son but est dans la BB
  (let ((candidates nil))
  (dolist (regle *BR* candidates)
    (let ((idRegle (car regle)))
    (if (custom_member (but idRegle) *BB*)
      (push regle candidates)))
  ))
)

(defun update_BB ()
  (dolist (r (regles_candidates_arriere) nil)
    (dolist (p (premisses (car r)) nil)
      (cond
        ((and (not (custom_member p *BB*)) (not (custom_member p *BF*)) (but_atteignable p))
          (push p *BB*))
        ((not (custom_member p *BB*)) ; Cas où l'on doit chercher plus en profondeur
          (let ((regle_p nil))
          (dolist (regle *BR* nil) ; On va chercher la regle qui a pour but la premisse
            (if (eq (cadr (but (car regle))) (cadr p))
              (setq regle_p regle))
          )
          (dolist (p2 (premisses (car regle_p)) nil)
            (if (and (not (custom_member p2 *BB*)) (not (custom_member p2 *BF*)) (but_atteignable p2)) (push p2 *BB*))
          ))
        )
      )
    )
  )
)

(defun moteur_arriere (maison)
  (let ((bon_choix nil) (nb_regles_candidates_avant nil) (nb_regles_candidates_apres nil))
  (push maison *BB*) ; La base de buts contient la maison à tester qui nous interesse
  (update_BB)
    (loop
      (setq nb_regles_candidates_avant (list-length (regles_candidates_arriere)))
      (update_BB)
      (setq nb_regles_candidates_apres (list-length (regles_candidates_arriere)))
      (cond
        ((bon_choix_maison maison)
          (format t "~% Vous avez fait le bon choix en choisissant ~A ! ~%" (cadr maison)))
        ((eq nb_regles_candidates_avant nb_regles_candidates_apres) ; Si le moteur arrière est bloqué
          (format t "~% Votre intégration à ~A était une erreur... Utilisez le moteur avant pour savoir quelle maison vous correspond. ~%" (cadr maison)))
        (t (update_BB)))
    (when (or (bon_choix_maison maison) (eq nb_regles_candidates_avant nb_regles_candidates_apres)) (return t))) ; On va s'arrêter si la maison est la bonne ou si le nombre de regle candidate stagne
  )
)


;------ Tentative 2 de moteur arriere -----

;(defun bon_choix_arriere ()

;(defun moteur_arriere2 ()

; -- QUESTIONS

(setq *Questions*
      '((1 "En quelle bois est faites votre baguette ? " (surreau chaine) baguette)
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
                    (format T "|-----------------------------------------------------------------------|~%")
                    (format T "->")
                    (setq maison (read))
                        (loop while (not (or (eq maison 'Gryffondor) (eq maison 'Serpentard) (eq maison 'Poufsouffle) (eq maison 'Serdaigle))) do
                            (format T "~%")
                            (format T "-> Le choix est une des quatres maisons.~%")
                            (format T "->")
                            (setq maison (read))
                        )
                        (setq maison (list 'maison maison)) ; Attention à mettre la valeur sous la forme (maison choix) pour utiliser le moteur arriere
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
