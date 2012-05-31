.section .bss
.lcomm str,100

.section .data
format: .asciz "%s"

.section .text
.globl main 
main:
	pushl $str
	pushl $format
	call scanf
	addl $8,%esp

	pushl $str
	pushl $format
	call printf
	addl $8,%esp

	pushl $0
	call exit
