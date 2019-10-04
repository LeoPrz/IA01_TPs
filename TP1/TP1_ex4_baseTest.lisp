(setq BaseTest
    '(
        (
            "Campagnes de Clovis Ier"
            486
            508
            (
                (
                    "Royaume Franc"
                )
                (
                    "Soissons"
                    "Royaume alaman"
                    "Royaume des Burgondes"
                    "Royaume wisigoth"
                    "Royaume ostrogoth"
                    "Royaume wisigoth"
                )
            )
            (
                "Soissons"
                "Zulpich"
                "Dijon"
                "Vouille"
                "Arles"
            )
        )
        (
            "Guerre de Burgondie"
            523
            533
            (
                (
                    "Royaume Franc"
                )
                (
                    "Royaume des Burgondes"
                )
            )
            (
                "Vezeronce"
                "Arles"
            )
        )
        (
            "Conquete de la Thuringe"
            531
            531
            (
                (
                    "Royaume Franc"
                )
                (
                    "Thuringes"
                )
            )
            (
                "Thuringe"
            )
        )
        (
            "Guerre des Goths"
            535
            553
            (
                (
                    "Royaume ostrogoth"
                )
                (
                    "Empire byzantin"
                )
            )
            (
                "Péninsule italienne"
            )
        )
        (
            "Conquête de l'Alémanie"
            536
            536
            (
                (
                    "Royaume franc"
                )
                (
                    "Alamans"
                )
            )
            (
                "Alemanie"
            )
        )
        (
            "Conquete de la Baviere"
            555
            555
            (
                (
                    "Royaume franc"
                )
                (
                    "Bavarii"
                )
            )
            (
                "Baviere"
            )
        )
        (
            "Campagnes de Bretagne"
            560
            578
            (
                (
                    "Royaume franc"
                )
                (
                    "Royaume du Vannetais"
                )
            )
            (
                "Vannetais"
            )
        )
        (
            "Guerre de succession mérovingienne"
            584
            585
            (
                (
                    "Royaume franc"
                )
                (
                    "Royaume d'Aquitaine"
                )
            )
            (
                "Comminges"
            )
        )
        (
            "Guerre franco-frisonne"
            600
            793
            (
                (
                    "Royaume franc"
                )
                (
                    "Royaume de Frise"
                )
            )
            (
                "Pays-Bas"
                "Allemagne"
            )
        )
        (
            "Guerre civile des Francs"
            715
            719
            (
                (
                    "Neustrie"
                )
                (
                    "Austrasie"
                )
            )
            (
                "Royaume Franc"
            )
        )
        (
            "Invasion omeyyade en France"
            719
            759
            (
                (
                    "Royaume franc"
                )
                (
                    "Califat omeyyade"
                )
            )
            (
                "Royaume d'Aquitaine"
                "Septimanie"
            )
        )
        (
            "Guerre des Lombards"
            755
            758
            (
                (
                    "Royaume franc"
                )
                (
                    "Lombards"
                )
            )
            (
                "Lombardie"
            )
        )
        (
            "Guerre d'Aquitaine"
            761
            768
            (
                (
                    "Royaume franc"
                )
                (
                    "Aquitains"
                )
            )
            (
                "Vasconie Aquitaine"
            )
        )
        (
            "Guerre des Saxons"
            772
            804
            (
                (
                    "Royaume franc"
                )
                (
                    "Saxons"
                )
            )
            (
                "Germanie"
            )
        )
        (
            "Guerre des Lombards"
            773
            774
            (
                (
                    "Royaume franc"
                )
                (
                    "Lombards"
                )
            )
            (
                "Lombardie"
            )
        )
        (
            "Guerre des Avars"
            791
            805
            (
                (
                    "Royaume de France"
                )
                (
                    "Avars"
                )
            )
            (
                "Pannonie"
            )
        )
        (
            "Invasions sarrasines en Provence"
            798
            990
            (
                (
                    "Royaume de France"
                    "Comité de Provence"
                )
                (
                    "Sarrasins"
                )
            )
            (
                "Provence"
            )
        )
        (
            "Luttes inter-dynastiques carolingiennes"
            830
            842
            (
                (
                    "Francie occidentale"
                    "Francie orientale"
                )
                (
                    "Francie mediane"
                )
            )
            (
                "Fontenoy"
            )
        )
        (
            "Guerre franco-bretonne"
            843
            851
            (
                (
                    "Royaume de France"
                )
                (
                    "Royaume de Bretagne"
                    "Vikings"
                )
            )
            (
                "Royaume de Bretagne"
            )
        )
        (
            "Luttes inter-dynastiques carolingiennes"
            876
            946
            (
                (
                    "Francie occidentale"
                    "Francie orientale"
                )
                (
                    "Royaume de Bourgogne"
                    "Francie orientale"
                )
            )
            (
                "Ardennes"
                "Saône-et-Loire"
                "Rhenanie-Palatinat"
                "Aisne"
            )
        )
        (
            "Invasions vikings en France"
            799
            1014
            (
                (
                    "Royaume de France"
                )
                (
                    "Vikings"
                )
            )
            (
                "Normandie"
                "Bretagne"
            )
        )
        (
            "Premiere croisade"
            1096
            1099
            (
                (
                    "Comte de Blois"
                    "Comte de Toulouse"
                    "Comte de Boulogne"
                    "Marquisat de Provence"
                    "Comte de Flandre"
                    "Duche de Normandie"
                    "Diocese du Puy-en-Velay"
                    "Comte de Vermandois"
                    "Republique de Genes"
                    "Duche de Basse-Lotharingie"
                    "Principaute de Tarente"
                    "Empire byzantin"
                    "Royaume de Petite-Armenie"
                    "Croises"
                    "Royaume de France"
                )
                (
                    "Sultanat de Roum Danichmendides"
                    "Califat fatimide"
                )
            )
            (
                "Terre Sainte"
            )
        )
    )
)

(defun dateDebut (conflit)
    (cadr conflit)
)

(defun nomConflit (conflit)
    (car conflit)
)

(defun allies (conflit)
    (car (cadddr conflit))
)

(defun ennemis (conflit)
    (cadr (cadddr conflit))
)

(defun lieu (conflit)
    (nthcdr 4 conflit)
)

(defun FB1 (conflits)
    (dolist (x conflits NIL)
        (print (nomConflit x))
    )
)

;(FB1 BaseTest)

(defun FB2 (conflits)
  (dolist (x conflits NIL)
    (if (not (equal (member "Royaume franc" (allies x) :test #'string=) NIL)) (print (nomConflit x))
      NIL
    )
  )
)

;(FB2 BaseTest)

(defun FB3 (conflits a)
  (dolist (x conflits NIL)
    (if (not (equal (member a (allies x) :test #'string=) NIL)) (print (nomConflit x))
      NIL
    )
  )
)

;(FB3 BaseTest "Royaume franc")

(defun FB4 (conflits)
  (dolist (x conflits NIL)
    (if (equal 523 (dateDebut x)) (print (nomConflit x))
      NIL
    )
  )
)

;(FB4 BaseTest)

(defun FB5 (conflits)
  (dolist (x conflits NIL)
    (if (and (>= (dateDebut x) 523) (<= 715 (dateDebut x))) (print (nomConflit x))
      NIL
    )
  )
)

;(FB5 BaseTest)

(defun FB6 (conflits)
  (length (ennemis "Lombards"))
)

;(write (FB6 BaseTest))

;(ennemis ("Guerre de Burgondie" 523 533 (("Royaume Franc") ("Royaume des Burgondes")) ("Vezeronce" "Arles")))

(write (ennemis '("Guerre de Burgondie" 523 533 (("Royaume Franc") ("Royaume des Burgondes")) ("Vezeronce" "Arles"))))
