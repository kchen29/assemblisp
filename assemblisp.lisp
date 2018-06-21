(defmacro binary (name)
  `(defmacro ,name (a b)
     (let ((control-string (mkstr ',name " ~S, ~S~%")))
       `(format t ,control-string ',a ',b))))

(defmacro binaries (&rest names)
  `(progn
     ,@(loop for name in names
             collect `(binary ,name))))

(defmacro unary (name)
  `(defmacro ,name (a)
     (let ((control-string (mkstr ',name " ~S~%")))
       `(format t ,control-string ',a))))

(defmacro unaries (&rest names)
  `(progn
     ,@(loop for name in names
             collect `(unary ,name))))

(defmacro nullary (name)
  `(defmacro ,name ()
     (let ((name ',name))
       `(format t "~S~%" ',name))))

(defmacro nullaries (&rest names)
  `(progn
     ,@(loop for name in names
             collect `(nullary ,name))))

(binaries mov xor)
(unaries .global .ascii)
(nullaries syscall .text)

(defmacro label (a)
  `(format t "~S:~%" ',a))

;;;funky stuff: redo the macro for " so that the reader and printer don't actually change the string
;;;reading and printing "\n" should come out as "\n"
(defun escaped-string-reader (stream char)
  (let ((chars (list char)))
    (do ((cur (read-char stream) (read-char stream)))
        ((char= cur #\") (push #\" chars))
      (if (char= cur #\\)
          (let ((next (read-char stream)))
            (if (or (char= next #\\) (char= next #\"))
                (push next chars)
                (progn (push cur chars) (push next chars))))
          (push cur chars)))
    (coerce (nreverse chars) 'string)))

;; (set-macro-character #\" #'escaped-string-reader)

;;keep lowercase names as lowercase
(setf (readtable-case *readtable*) :invert)
