.text
.globl _start

_start:

pushl %eax
pushl $17
pushl $3
call add
movl %eax, %ebx #Linea 10

addl $(4*2), %esp

movl $1, %eax
int $0x80

.type add, @function
.globl add

add:

pushl %ebp
movl %esp, %ebp

pushl %ebx

movl 8(%ebp), %ebx
movl 12(%ebp), %eax

addl %ebx, %eax

popl %ebx
leave
ret
