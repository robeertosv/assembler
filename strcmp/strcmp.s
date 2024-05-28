.data

cadena1: .string "hola"
cadena2: .string "hola"

.text
.globl _start

_start:

pushl %eax
pushl $cadena1
pushl $cadena2
call strcmp

movl %eax, %ebx
addl (4*2), %esp

movl $1, %eax
movl $0, %ebx
int $0x80

.type strcmp, @function
.globl strcmp

strcmp:

pushl %ebp
movl %esp, %ebp

pushl %esi
pushl %edi
pushl %ecx

movl 8(%ebp), %esi
movl 12(%ebp), %edi
xorl %ecx, %ecx
xorl %eax, %eax

comparar:

movb (%esi), %cl
subb (%edi), %cl
je seguir
movl %ecx, %eax
jmp fin

seguir:
cmpb $0, (%edi)
je fin
incl %esi
incl %edi
jmp comparar

fin:

popl %ecx
popl %edi
popl %esi
leave
ret
