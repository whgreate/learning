.section .data
pid: .int 0
uid: .int 0
gid: .int 0

.section .text
.globl _start
_start:
	nop

	movl $20, %eax
	int $0x80
	movl %eax,pid
	
	movl $24,%eax
	int $0x80
	movl %eax,uid

	movl $47,%eax
	int $0x80
	movl %eax,gid	

	movl $1, %eax
	int $0x80
