.data
cadena1: .string "hola"
cadena2: .string "adios"
.text
.globl _start
_start:

pushl %eax
pushl $cadena1
pushl $cadena2
call strstr

movl %eax, %ebx #Linea 13
addl (4*2), %esp

movl $1, %eax
movl $0, %ebx
int $0x80

.type strstr, @function
.globl strstr
strstr:

pushl %ebp
movl %esp, %ebp

pushl %esi
pushl %edi
pushl %ecx

movl 8(%ebp), %esi

busco_1_caracter:
movl 12(%ebp), %edi
xorl %ecx, %ecx
xorl %eax, %eax

movb (%edi), %cl

pushl %eax
pushl %ecx
pushl %esi
call strchr
movl %eax, %esi
addl $(2*4), %esp
pop %eax

cmpl $0, %esi
je fin

movl %esi, %eax

siguientes:
incl %esi
incl %edi
movb (%edi), %cl
cmpb $0, %cl
je fin

cmpb %cl, (%esi)
je siguientes

cmpb $0, (%esi)
jne busco_1_caracter
movl $0, %eax

fin:

popl %ecx
popl %edi
popl %esi
leave
ret
