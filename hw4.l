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

;11 MY-ADD
(defun my-add-digits (a b c)
  (let ((s (+ a b c)))
    (cons (mod s 10) (floor (/ s 10)))))

(defun my-add-helper (n1 n2 carry)
  (cond ((and (null n1) (null n2))
         (cond ((= carry 0) nil) (t (list carry))))
        (t (let ((d1 (cond ((null n1) 0) (t (car n1))))
               (d2 (cond ((null n2) 0) (t (car n2)))))
            (let* ((p (my-add-digits d1 d2 carry))
                   (sd (car p)) (nc (cdr p)))
              (cons sd (my-add-helper (cond ((null n1) nil) (t (cdr n1)))
                                      (cond ((null n2) nil) (t (cdr n2))) nc)))))))

(defun MY-ADD (n1 n2)
  (let ((r (my-add-helper n1 n2 0)))
    (cond ((null r) '(0)) (t r))))

;12 MY-MERGE
(defun my-merge (l1 l2)
  (cond ((null l1) l2)
    ((null l2) l1)
    ((< (car l1) (car l2)) (cons (car l1) (my-merge (cdr l1) l2)))
    (t (cons (car l2) (my-merge l1 (cdr l2))))))

;13 MY-SUBLIST
(defun my-prefix-p (l1 l2)
  (cond ((null l1) t)
    ((null l2) nil)
    ((eq (car l1) (car l2)) (my-prefix-p (cdr l1) (cdr l2)))
    (t nil)))

(defun my-sublist (l1 l2)
  (cond ((null l1) t)
    ((null l2) nil)
    ((my-prefix-p l1 l2) t)
    (t (my-sublist l1 (cdr l2)))))

;14 MY-ASSOC
(defun my-assoc (a alist)
  (cond ((null alist) nil)
    ((eq a (car (car alist))) (car alist))
    (t (my-assoc a (cdr alist)))))

;15 MY-REPLACE
(defun my-replace (alist l)
  (cond ((atom l) (let ((p (my-assoc l alist)))
    (cond (p (cdr p)) (t l))))
  (t (cons (my-replace alist (car l))
           (my-replace alist (cdr l))))))

      

