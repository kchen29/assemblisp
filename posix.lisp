(defmacro posix-write (file-handle string bytes)
  "Writes BYTES bytes from STRING to FILE-HANDLE."
  `(progn
     ;; system call 1 is write
     (mov $1 %rax)
     (mov ,file-handle %rdi)
     (mov ,string %rsi)
     (mov ,bytes %rdx)
     (syscall)))

(defmacro posix-exit (val)
  "Exits the program with VAL."
  `(progn
     ;; system call 60 is exit
     (mov $60 %rax)
     (mov ,val %rdi)
     (syscall)))

