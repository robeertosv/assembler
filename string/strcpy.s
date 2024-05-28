.type strcpy, @function
.globl strcpy

strcpy:

pushl %ebp
movl %esp, %ebp

pushl %esi #Iterador
pushl %edi #temp
pushl %ecx

movl 8(%ebp), %edi
movl 12(%ebp), %esi
movl %esi, %eax

copiar:
movb (%esi), %cl
movb %cl, (%edi)
cmpb $0, %cl
je fin
incl %esi
incl %edi
jmp copiar

fin:
popl %ecx
popl %edi
popl %esi
leave
ret
