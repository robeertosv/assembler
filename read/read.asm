.data

msg: .ascii "Introduce tu nombre\n"
msg_len = .-msg

buffer: .space 20
buffer_len = 20

name: .ascii "Tu nombre es: "
name_len = .-name

.text
.global _start

_start:

movl $4, %eax
movl $1, %ebx
movl $msg, %ecx
movl $msg_len, %edx
int $0x80

movl $3, %eax
movl $0, %ebx
movl $buffer, %ecx
movl $buffer_len, %edx
int $0x80

movl $4, %eax
movl $0, %ebx
movl $name, %ecx
movl $name_len, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
movl $buffer, %ecx
movl $buffer_len, %edx
int $0x80

movl $1, %eax
movl $0, %ebx
int $0x80
