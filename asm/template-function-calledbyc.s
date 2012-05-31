.section .data

.section .text
.type functionName,@function
.globl functionName
functionName:
	pushl %ebp
	movl %esp, %ebp
	sub $N, %esp
	pushl %edi
	pushl %esi
	pushl %ebx

	...
	
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp, %esp
	popl %ebp
	ret

.globl _start
_start:
	nop
	
	pushl param1
	pushl param2
	pushl param3
	call funcionName
	addl $12, %esp
	
	movl $1, %eax
	int $0x80
