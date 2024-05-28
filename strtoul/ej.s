.data
msg: .ascii "Introduce una cadena de numeros: "
len = .-msg

buffer: .space 20
.text
.globl _start

_start:

movl $4, %eax
movl $1, %ebx
leal msg, %ecx
leal len, %edx
int $0x80

movl $3, %eax
movl $0, %ebx
leal buffer, %ecx
movl $20, %edx
int $0x80

pushl %eax
pushl $buffer
call strtoul

addl $(4*1), %esp
movl %eax, %ebx
movl $1, %eax
int $0x80 

.type strtoul, @function
.globl strtoul

strtoul:

pushl %ebp
movl %esp, %ebp

movl 8(%ebp), %ebx

pushl %ecx
pushl %edx
pushl %esi
pushl %edi

movl $0, %eax
movl $0, %esi
movl $10, %edi

code:

movb (%ebx, %esi), %cl
cmpb $0, %cl
je salir

cmpb $'0', %cl
jb salir

cmpb $'9', %cl
ja salir

andl $0x0F, %ecx
mull %edi
jo of_err

addl %ecx, %eax
jo of_err

incl %esi
jmp code

of_err:
movl $0xFFFFFFFF, %eax
salir:
leave 
ret
