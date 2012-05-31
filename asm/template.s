.section .data

.section .text
.globl _start
_start:
	nop
	movl $1, %eax
	int $0x80
