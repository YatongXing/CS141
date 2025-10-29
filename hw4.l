;1 MY-LENGTH
(defun MY-LENGTH (L)
  (cond ((null L) 0)
    (t (+ 1 (MY-LENGTH (cdr L))))))

;2 MY-MEMQ
(defun MY-MEMQ (A L)
  (cond ((null L) nil)
    ((eq A (car L)) L)
    (t (MY-MEMQ A (cdr L)))))

;3 MY-APPEND
(defun MY-APPEND (l1 l2)
  (cond ((null l1) l2)
    (t (cons (car l1) (MY-APPEND (cdr l1) l2)))))

;4 MY-REVERSE
(defun MY-REVERSE (l) (rev l nil))

(defun rev (l r)
  (cond ((null l) r)
    (t (rev (cdr l) (cons (car l) r)))))

;5 MY-MAPCAR
(defun MY-MAPCAR (f l)
  (cond ((null l) nil)
    (t (cons (apply f (list (car l))) (MY-MAPCAR f (cdr l))))))

;6 MY-COPY
(defun MY-COPY (l)
  (cond ((atom l) l)
    ((listp l) (cons (MY-COPY(car l)) (MY-COPY (cdr l))))))

;7 MY-NTH
(defun MY-NTH (l n)
  (cond ((< n 0) nil)
    ((= n 0) (cons nil l))
    ((null l) nil)
    ((= n 1) l)
    ((> n 0) (MY-NTH (cdr l) (1- n)))))

;8 MY-REMOVE
(defun MY-REMOVE (x l)
  (cond ((null l) nil)
    ((equal x (car l)) (MY-REMOVE x (cdr l)))
    (t (cons (car l) (MY-REMOVE x (cdr l))))))

;9 MY-SUBST
(defun MY-SUBST (x y z)
  (cond ((atom z) (cond ((eq z x) y) (t z)))
        (t (cons (MY-SUBST x y (car z))
                 (MY-SUBST x y (cdr z))))))

;10 MY-SUBSET
(defun MY-SUBSET (fn l)
  (cond ((null l) nil)
  ((apply fn (list (car l))) (cons (car l) (MY-SUBSET fn (cdr l))))
  (t (MY-SUBSET fn (cdr l)))))





