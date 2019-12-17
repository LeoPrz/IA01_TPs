; BASE DE REGLES
(setq *BR* '(
  (R1 ((qualite courage) (sortilege Expelliarmus)) (maison Gryffondor))
  (R2 ((qualite malice) (temperament bagarreur)) (maison Serpentard))
  (R3 ((valeur justice) (temperament travailleur)) (maison Poufsouffle))
  (R4 ((valeur sagesse) (sortilege Legilimens)) (maison Serdaigle))

  (R5 ((qualité curieux) (boisson biere)) (qualite courage))
  (R6 ((qualite adroit) (notes bon)) (qualite malice))

  (R7 ((animal chien) (karma non)) (temperament bagarreur))
  (R8 ((milieu populaire) (fetard non)) (temperament travailleur))

  (R9 ((karma oui) (type extraverti)) (valeur justice))
  (R10 ((milieu bourgeois) (boisson vin)) (valeur sagesse))

  (R11 ((valeur justice) (fetard oui)) (sortilege Expelliarmus))
  (R12 ((animal chat) (type introverti)) (sortilege Legilimens))
))

; Les valeurs de Poufsouffle sont la loyauté, la patience, la gentillesse, la modestie, le travail acharné, le fair-play, la persévérance la justice, la sincérité,, la tolérance, et l'amour de la nature.
; Si vous êtes sage et réfléchi, Serdaigle vous accueillera peut-être, Là-bas, ce sont des érudits, Qui ont envie de tout connaître.

; début de base de règle
; il faut ajouter des règles et prolonger l'arbre
