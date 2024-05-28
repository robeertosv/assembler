.data

msg: .ascii "Introduce un número: "
len = .- msg
buffer: .space 20

msgB: .ascii "\nIntroduce una base: "
lenB = .- msgB
base: .space 3

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
movl $buffer, %ecx
movl $20, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
leal msgB, %ecx
leal lenB, %edx
int $0x80

movl $3, %eax
movl $0, %ebx
movl $base, %ecx
movl $3, %edx
int $0x80


pushl %eax #Retorno
pushl $buffer #Numero
pushl $10 #Base

call strtoul
movl %eax, %edx

addl $(4*2), %esp
popl %eax

movl $1, %eax
movl $0, %ebx
int $0x80

.type strtoul, @function
.globl strtoul

strtoul:

pushl %ebp
movl %esp, %ebp

movl 8(%ebp), %ebx #Numero
movl 12(%ebp), %edi #Base

xorl %esi, %esi
xorl %eax, %eax

codificar:

movb (%ebx, %esi), %dl

cmpb $0, %dl
je salir

cmpb $'0', %dl
jb salir

cmpb $'F', %dl
ja salir

andl $0x0F, %edx
mull %edi
jo of_err

addl %edx, %eax
jo of_err

of_err:

movl $0xFFFFFFFF, %eax

salir:

popl %ecx
popl %ebx
leave
ret

