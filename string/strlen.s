.type strlen, @function
.globl strlen

strlen:

pushl %ebp
movl %esp, %ebp

pushl %ebx
pushl %ecx

movl 8(%ebp), %ebx

xorl %eax, %eax

bucle:

movb (%ebx, %eax), %cl
cmpb $0x0, %cl
je salir

inc %eax
jmp bucle

salir:
popl %ecx
popl %ebx
leave
ret

