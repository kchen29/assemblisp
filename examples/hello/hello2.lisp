(.global _start)

(.text)

(label _start)
(posix-write $1 $message $13)

(posix-exit $0)

(label message)
(.ascii  "Hello, world\\n")

