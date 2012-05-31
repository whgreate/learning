.section .data
var:
	.int 100,150,200,250,300,350,400,450
	num=255
.section .text
.globl _start
_start:
	nop
	movl var,%eax
	movl $var,%edi
	movl $num,8(%edi)
	movl $2,%edi
	movl var(,%edi,4),%ebx
	movl $1, %eax
	int $0x80
