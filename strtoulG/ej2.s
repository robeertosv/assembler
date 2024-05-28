.data

msg: .ascii "Introduce una cadena de numeros: "
len = .- msg

buffer: .space 21
.text
.globl _start

_start:

movl $4, %eax
movl $1, %ebx
movl $msg, %ecx
movl $len, %edx
int $0x80

movl $3, %eax
movl $0, %ebx
movl $buffer, %ecx
movl $21, %edx
int $0x80

pushl %eax
#pushl $10
pushl $buffer
call strtoul

movl %eax, %ebx
addl (4*1), %esp
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

andb $0x0F, %cl
mull %edi
jo of_err
addl %ecx, %eax
jo of_err

inc %esi
jmp code
of_err:

movl $0xFFFFFFFF, %eax

salir:

leave
ret
