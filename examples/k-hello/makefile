output := output

all:
	gcc -m32 -c $(output).s
	ld -m elf_i386 -T link.ld -o kernel $(output).o

