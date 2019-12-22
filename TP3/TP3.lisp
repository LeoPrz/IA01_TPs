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

; Les valeurs de Poufsouffle sont la loyauté, la patience, la gentillesse, la modestie, le travail acharné, le fair-play, la persévérance la justice, la sincérité,, la tolérance, et l'amour de la nature.
; Si vous êtes sage et réfléchi, Serdaigle vous accueillera peut-être, Là-bas, ce sont des érudits, Qui ont envie de tout connaître.

; début de base de règle
; il faut ajouter des règles et prolonger l'arbre
