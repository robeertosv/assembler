.data
.text
.globl _start

_start:

pushl %eax
pushl $16
pushl $4
call suma
movl %eax, %ebx

addl $(4*2), %esp
popl %eax

movl $1, %eax
int $0x80

.type suma, @function
.globl suma

suma:

pushl %ebp
movl %esp, %ebp

pushl %ebx

movl 8(%ebp), %ebx
movl 12(%ebp), %eax

addl %ebx, %eax
jno salir
movl $-1, %eax

salir:

popl %ebx
leave
ret

