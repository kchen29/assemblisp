sbcl := sbcl --noinform --non-interactive --load "load.lisp" --eval
script := examples/hello/hello.lisp
output := output

all: $(output).s
	gcc -c $(output).s
	ld $(output).o
	./a.out

$(output).s:
	$(sbcl) '(output-to-file "$(output).s" (load "$(script)"))'

clean:
	rm -f *~ *fasl output.* a.out
