.data

msg: .ascii "Hola\n"
len = .-msg

.text
.global _start

_start:

movl $4, %eax
movl $1, %ebx
movl $msg, %ecx
movl $len, %edx
jmp  _start
int $0x80

movl $1, %eax
movl $0, %ebx
int $0x80
