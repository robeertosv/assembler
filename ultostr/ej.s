.data

buffer: .space 32

.text

.globl _start

_start:

pushl %eax
pushl $16 #Base
pushl $buffer #Donde se va a guardar el programa
pushl $100 #Cociente inicial

call ultostr
movl %eax, %ebx
addl $(3*4), %esp

popl %eax

movl $4, %eax
movl $1, %ebx
movl $buffer, %ecx
movl $32, %edx
int $0x80

movl $1, %eax
movl $0, %ebx
int $0x80

.type ultostr, @function
.globl ultostr

ultostr:

pushl %ebp
movl %esp, %ebp

pushl %esi
pushl %edx
pushl %ebx

movl 8(%ebp), %eax #Numero a dividir
movl 12(%ebp), %edi #Puntero del buffer
movl 16(%ebp), %ebx #base

movl $0, %esi

compare:
cmpl $0, %eax
jz buildStr

division:
movl $0, %edx
divl %ebx
pushl %edx
inc %esi

cmpl $0, %eax
jnz compare

buildStr:
movl $0, %ecx

build:

pop %edx

cmpb $9, %dl
jbe numero

addb $'A', %dl
jmp concat
numero:
addb $'0', %dl

concat:
movb %dl, (%edi, %ecx)
inc %ecx
dec %esi
jnz build
salida:
popl %ebx
popl %esi
popl %edx
popl %edi

movl $0, %eax
leave
ret
