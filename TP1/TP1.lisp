; EXO 1 -------------------------------------------------

(defun nombres3 (L)
  (if (and (and (and (numberp (car L))) (numberp (cadr L))) (numberp (caddr L))) (princ "BRAVO !")
    (princ "PERDU !")
  )
)

;(nombres3 '( 1 2 3 R S 4))

(defun grouper (L1 L2)
  (if (and (not (equal L1 ())) (not (equal L2 ()))) (cons (list (car L1) (car L2)) (grouper (cdr L1) (cdr L2)))
  )
)

;(write (grouper '(1 2 3) '(4 5 6)))

(defun monReverse (L)
	(if (null L) NIL
		(append (monReverse (cdr L)) (list (car L)))
	)
)

;(write (monReverse '(1 2 3 4 5)))

(defun palindrome(L)
	(if (equal (monReverse L) L) T
		NIL
	)
)

;(write (palindrome '(x a m a x) ))

;eq est l'égalité des pointeurs & equal est l'égalité des symboles aux feuilles de l'objets
;On utilise pas eq pour les nombres et caractères

(defun monEqual (X1 X2)
(if (and (eq X1 NIL) (eq X2 NIL)) NIL
  (if (and (listp X1) (listp X2))
    (if (eq (car X1) (car X2)) (monEqual (cdr X1) (cdr X2))
      NIl
    )
    (if (eq X1 X2) T
      NIL)
  )
))

;(write (monEqual '(d p f t r) '(d p f t r)))

; EXO 2 -------------------------------------------------

(defun list-triple-couple (x)
    (mapcar (lambda (n) (list n (* 3 n))) x)
)

; EXO 3 -------------------------------------------------

(defun my-assoc (cle l)
  (dolist (x l NIL)
    (if (eq (car x) cle) (print x) NIL)
  )
)

;(my-assoc 'Pierre '((Yolande 25) (Pierre 22) (Julie 45)))

(defun cles (l)
  (if (eq l NIL) NIL
    (append (list (car (car  l))) (cles (cdr l))) ;Attention a ne pas oublier le "list" sinon exception pour le dernier elmt de l
  )
)

;(write (cles '((Yolande 25) (Pierre 22) (Julie 45))))


(defun creation (c v)
  (if (eq c NIL) NIL
    (append (list(append (list (car c)) (list (car v)))) (creation (cdr c) (cdr v)))
  )
)

;(write (creation '(Yolande Pierre Julie) '(25 22 45)))
