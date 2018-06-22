sbcl := sbcl --noinform --non-interactive --load "load.lisp" --eval

subdir := hello/
dir := examples/$(subdir)
script := hello.lisp
output := output

true-script := $(dir)$(script)
true-output := $(dir)$(output)

all: $(true-output).s
	cd $(dir) && $(MAKE) output=$(output)

$(true-output).s: $(true-script) assemblisp.lisp
	$(sbcl) '(output-to-file "$(true-output).s" (load "$(true-script)"))'

clean:
	find . -name "*~" -delete
	find . -name "*.fasl" -delete
	find . -name "output.s" -delete
	find . -name "*.o" -delete
	find . -name "a.out" -delete
