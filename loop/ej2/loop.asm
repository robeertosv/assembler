# El programa pide un string, si es "S" sale de programa, si es otra cosa, lo convierte a minúsculas

.data
msg: .ascii "Introduce una frase: "
len = .-msg
buffer: .space 21 #Se almacena lo que llegue por teclado (Incluye el \n final)
frase: .space 20 #Se almacena la frase a convertir
CL: .ascii "\n" #Para hacer el salto de linea al final del todo (opcional)
lcl = .-CL

.text

.globl _start

_start:
#Muestra el mensaje "Introduce una frase: "
movl $4, %eax
movl $1, %ebx
movl $msg, %ecx
movl $len, %edx
int $0x80

#Lee lo que se ha tecleado
movl $3, %eax
movl $0, %ebx
movl $buffer, %ecx
movl $21, %edx
int $0x80

#La función read() guarda en eax la longitud de la entrada
dec %eax #Se resta 1 a esa longitud para quitar el \n
movl %eax, %ecx # Necesario para usar loop
movl %eax, %ebp # Como ecx va a cambiar y luego hará falta otro bucle, guardar eax en ebp
movl $0, %esi
jmp sanitize

#Copiar el buffer en frase (ahora no incluye el \n)
sanitize:
movb buffer(%esi), %al
movb %al, frase(%esi)
inc %esi
loop sanitize

# Si la frase es la "S" salir, si no, pasar a minuscula
cmpl $'S', frase
je exit
jne noEsLaS

noEsLaS:
movl %ebp, %ecx #Set ecx a la longitud de la entrada anterior
movl $0, %esi
jmp transform
transform:
movb frase(%esi), %al
orb $0x20, %al # Máscara para pasar las letras a minúscula
movb %al, frase(%esi)
inc %esi
loop transform

#Mostrar la frase transformada
movl $4, %eax
movl $1, %ebx
movl $frase, %ecx
movl %ebp, %edx
int $0x80

#Hacer un salto de linea (opcional)
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
