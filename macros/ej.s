.data

msg: .ascii "Dime tu nombre: "
lenM: .-msg
nombre: .space 32
name: .ascii "Roberto"

correcto: .ascii "\nBienvenido"
lenC = .-correcto

no: .ascii "\nusuario no encontrado"
lenN = .-no


.macro print c l
movl $4, %eax
movl $1, %ebx
movl \c, %ecx
movl \l, %edx
int $0x80
.endm

.macro read s l
movl $3, %eax
movl $0, %ebx
movl \s, %ecx
movl \l, $edx
int $0x80
.endm

.macro exit
movl $1, %eax
movl $0, %ebx
int $0x80
.endm

.text
.globl _start
_start:

print $msg $lenM
read $nombre $4

cmp $name, $nombre
je correct
print $no $lenN
exit

correct:
print $correcto $lenC
exit
