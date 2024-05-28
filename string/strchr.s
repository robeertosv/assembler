.type strchr, @function
.globl strchr

strchr:

pushl %ebp
movl %esp, %ebp

pushl %ecx
pushl %esi

movl 8(%ebp), %esi
movl 12(%ebp), %ecx
movl $0, %eax

buscar:
cmpb $0, (%esi)
je finchr
cmpb %cl, (%esi)
je encontrado
incl %esi
jmp buscar

encontrado:
movl %esi, %eax

finchr:
popl %esi
popl %ecx

movl %ebp, %esp
popl %ebp
ret
