.section .bss
.comm output,13 

.section .text
.type cpuidfunc, @function
.globl cpuidfunc
cpuidfunc:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %edi

	movl $0, %eax
	cpuid
	movl $output,%edi
	movl %ebx,(%edi)
	movl %ecx,4(%edi)
	movl %edx,8(%edi)
	movl $output,%eax

	popl %edi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret

