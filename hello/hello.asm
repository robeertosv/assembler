.data

msg: .ascii "\nHello World\n"
len = .-msg
name: .ascii "Roberto Seco\n"
lenName = .-name

.text

.global _start

_start:
movl $4, %eax
movl $1, %ebx
movl $msg, %ecx
movl $len, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
movl $name, %ecx
movl $lenName, %edx
int $0x80

movl $1, %eax
movl $0, %ebx
int $0x80
