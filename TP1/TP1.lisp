; EXO 1 -------------------------------------------------

; EXO 2 -------------------------------------------------

(defun list-triple-couple (x)
    (mapcar (lambda (n) (list n (* 3 n))) x)
)

; EXO 3 -------------------------------------------------

; EXO 4 -------------------------------------------------
; (A) cf. TP1_ex4_baseTest.lisp

; (B)

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

