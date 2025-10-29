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



