; BASE DE REGLES
(setq *BR* '(
  (R1 ((qualite courage) (sortilege Expelliarmus)) (maison Gryffondor))
  (R2 ((qualite malice) (temperament bagarreur)) (maison Serpentard))
  (R3 ((valeur justice) (temperament travailleur)) (maison Poufsouffle))
  (R4 ((valeur sagesse) (sortilege Legilimens)) (maison Serdaigle))

  (R5 ((naturel curieux) (boisson biere)) (qualite courage))
  (R6 ((karma oui) (boisson eau)) (qualite courage))
  (R7 ((naturel adroit)) (qualite malice))
  (R8 ((karma oui) (boisson vin)) (qualite malice))

  (R9 ((valeur justice) (fetard oui)) (sortilege Expelliarmus))
  (R10 ((naturel curieux) (fetard oui)) (sortilege Expelliarmus))
  (R11 ((animal chat) (type introverti)) (sortilege Legilimens))
  (R12 ((animal chat) (boisson vin)) (sortilege Legilimens))

  (R13 ((animal chien) (karma non)) (temperament bagarreur))
  (R14 ((boisson biere) (fetard oui)) (temperament bagarreur))
  (R15 ((milieu populaire) (fetard non)) (temperament travailleur))
  (R16 ((boisson eau) (fetard non)) (temperament travailleur))

  (R17 ((karma oui) (type extraverti)) (valeur justice))
  (R18 ((boisson vin) (animal chien)) (valeur justice))
  (R19 ((milieu bourgeois) (boisson vin)) (valeur sagesse))
  (R20 ((milieu bourgeois) (type introverti)) (valeur sagesse))
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

(defun but_atteignables () ; Si un fait de la BF n'est pas dans la BB alors les buts ne sont pas atteignables, il faut decendre plus profond
  (let ((atteignables t))
  (dolist (x *BB* atteignables)
    (if (not (custom_member x *BF*))
      (setq atteignables nil))
  ))
)

; -- PRESENCE DES PREMISSES DANS LA BASE DE BUTS --
(defun presence_premisses_BB (premisses)
  (let ((presence t))
  (dolist (x premisses presence)
    (if (not (custom_member x *BB*)) (setq presence nil)) ; Si une des premisse n'est pas dans la BF alors on va renvoyer nil
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
      (if (not (custom_member p *BB*))
        (push p *BB*))
    )
  )
)

(defun moteur_arriere (maison)
  (let ((bon_choix nil))
  (push maison *BB*) ; La base de buts contient la maison à tester qui nous interesse
  (cond
    ((but_atteignables)
      (format t "Vous avez fait le bon choix en choisissant ~A ! " maison))
    ((eq (regles_candidates_arriere) nil) ; Si le moteur arrière est bloqué
      (format t "Votre intégration à ~A était une erreur... Utilisez le moteur avant pour savoir quelle maison vous correspond." maison))
    (t
      (loop
        (update_BB)
        (format t "Oupsi : ~A" *BB*)
        (cond
          ((but_atteignables)
            (format t "Vous avez fait le bon choix en choisissant ~A ! " maison))
          ((eq (regles_candidates_arriere) nil) ; Si le moteur arrière est bloqué
            (format t "Votre intégration à ~A était une erreur... Utilisez le moteur avant pour savoir quelle maison vous correspond." maison))
          (t nil))
      (when (or (but_atteignables) (eq (regles_candidates_arriere) nil)) (return t))))
    ))
)




; -- SCENARIOS AVANT -- A retirer par la suite quand on proposera à l'utilisateur de répondre aux questions

(defun scenario1 ()
  (setq *BF* '(
    (karma oui)
    (animal chien)
    (boisson biere)
    (fetard non)
    (type extraverti)
    (naturel adroit)
    (milieu populaire)
  ))
  (push '(maison Poufsouffle) *BB*)
  (write (regles_candidates_arriere)))
  ;(moteur_arriere '(maison Poufsouffle)))

(scenario1)
