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
