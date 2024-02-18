.data

buffer: .space 2
msg: .ascii "Introduce una letra: "
len = .-msg

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
movl $2, %edx
int $0x80
movl $0, %esi
cmpb $'S', buffer(%esi)
jne _start


movl $1, %eax
movl $0, %ebx
int $0x80
