(defun mkstr (&rest rest)
  "Creates a string. Princs each form in REST and collects it."
  (with-output-to-string (out)
    (dolist (form rest)
      (princ form out))))

(defmacro output-to-file (file &body body)
  "Redirects output from BODY to *STANDARD-OUTPUT* to the file."
  `(with-open-file (s ,file :direction :output :if-exists :supersede)
     (let ((*standard-output* s))
       ,@body)))
