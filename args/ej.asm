.data
LF: .ascii "\n" 
.text
.globl _start

_start:
	popl %edi
	cmpl $10, %edi
	jge exit
	movl %edi, %ecx

readARGS:
	movl $0, %esi
	popl %ebx

		looper:
			inc %esi
			cmpb $0, -1(%ebx, %esi)
			jne looper

	pushl %ecx

	movl $4, %eax
	movl %ebx, %ecx
	movl $1, %ebx
	movl %esi, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	leal LF, %ecx
	movl $1, %edx
	int $0x80

	popl %ecx
	loop readARGS
exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
