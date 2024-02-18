.data
msg: .ascii "Introduce una frase: "
len = .-msg
buffer: .space 21
frase: .space 20
CL: .ascii "\n"
lcl = .-CL

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

dec %eax
movl %eax, %ecx
movl %eax, %ebp
movl $0, %esi
jmp sanitize

sanitize:
movb buffer(%esi), %al
movb %al, frase(%esi)
inc %esi
loop sanitize

cmpl $'S', frase
je exit
jne noEsLaS

noEsLaS:
movl %ebp, %ecx
movl $0, %esi
jmp transform
transform:
movb frase(%esi), %al
orb $0x20, %al
movb %al, frase(%esi)
inc %esi
loop transform

movl $4, %eax
movl $1, %ebx
movl $frase, %ecx
movl %ebp, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
movl $CL, %ecx
movl $lcl, %edx
int $0x80
jmp exit

exit: 
movl $1, %eax
movl $0, %ebx
int $0x80
