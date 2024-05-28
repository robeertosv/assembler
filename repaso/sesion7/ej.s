.data

num: .ascii "Introduce un número"
len = .- num
buffer: .space 5

.text
.globl _start

_start:

movl $4, %eax
movl $1, %ebx
leal num, %ecx
leal len, %edx
int $0x80

movl $3, %eax
movl $0, %ebx
movl $buffer, %ecx
movl $5, %edx
int $0x80

pushl %eax
pushl $buffer
call strtoul

movl %eax, %ebx #Linea 28

addl $(4*1) , %esp
popl %eax

movl $1, %eax
int $0x80

.type strtoul, @function
.globl strtoul

strtoul:

pushl %ebp
movl %esp, %ebp

pushl %ebx
movl 8(%ebp), %ebx

xorl %esi, %esi
xorl %eax, %eax
movl $10, %edi #La base a la que queremos convertir

codificar:

movb (%ebx, %esi), %cl

cmpb $0, %cl
je salir

cmpb $'0', %cl
jb salir

cmpb $'9', %cl
ja salir

andl $0x0F, %ecx
mull %edi
jo salir
addl %ecx, %eax
jo salir
incl %esi
jmp codificar

salir:

popl %ebx
leave 
ret



