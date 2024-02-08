.data

name: .space 20

buffer: .space 20

cuenta: .byte 20
msg: .ascii "\n"

.text
.globl _start

_start:

# Leer el nombre
movl $3, %eax
movl $0, %ebx
movl $name, %ecx
movl $20, %edx
int $0x80


# Pintar lo que se ha escrito

# for(int esi = 0; esi<cuenta; esì++)
decl %eax
movl %eax, %edx
movl %edx, %ecx
movl $0, %esi
bucle:
movb name(%esi),  %al
andb $0xdf, %al
movb %al, buffer(%esi)
incl %esi
loop bucle

movl $4, %eax
movl $1, %ebx
movl $buffer, %ecx
movl $20, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
movl $msg, %ecx
movl $1, %edx
int $0x80

movl $1, %eax
movl $0, %ebx
int $0x80
