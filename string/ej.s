.data

cadena1: .string "roberto"
cadena2: .string "seco"

.text
.globl _start
_start:

pushl %eax
pushl $cadena1
pushl $cadena2
call strcat

movl $64, %edx
movl $cadena1, %ecx
movl $1, %ebx
movl $4, %eax
int $0x80

movl %eax, %ebx
movl $1, %eax
movl $0, %ebx
int $0x80

