.type strcat, @function
.globl strcat
strcat:
pushl %ebp
movl %esp, %ebp

pushl %esi
pushl %edi
pushl %ecx

movl 8(%ebp), %esi #Cadena origen
movl 12(%ebp), %edi #Cadena a concatenar

xorl %ecx , %ecx

encontrarFinal:

cmpb $0x0, (%esi)
je concatenar
incl %esi
jmp encontrarFinal

concatenar:
movb (%edi), %cl
movb %cl, (%edi)
cmpb $0x0, %cl
je salir
incl %esi
incl %edi
jmp concatenar

salir:
popl %ecx
popl %edi
popl %esi

leave
ret

