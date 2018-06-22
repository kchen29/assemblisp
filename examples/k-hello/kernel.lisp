;;;;kernel.lisp - kernel.s and kernel.c

(.code32)
(.text)
;;multiboot spec
(.align 4)
(.long 0x1BADB002)              ;magic
(.long 0x00)                    ;flags
(.long "- (0x1BADB002 + 0x00)") ;checksum. m+f+c should be zero

(.global _start)
(.extern kmain)	        ;kmain is defined in the c file

(label _start)
(cli) 			;block interrupts
(mov $stack_space %esp)	;set stack pointer
(call kmain)
(hlt)		 	;halt the CPU

(.section .bss)
(.comm stack_space 8192)	;8KB for stack

