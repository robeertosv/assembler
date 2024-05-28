# Establece la posicion del cursor con el codigo ANSI.
# Primero comprueba si es posible actualizar la posicion.
# Argumentos:
#    1. La posicion de la cadena de texto con el codigo ANSI \033[FILA;COLH.
#    2. Las coordenadas de la nueva posicion.
# Devuelve:
#    1 si la posicion es valida y se ha actualizado el codigo ANSI.
#    0 si la posicion no es alcanzable y no se ha actualizado el codigo ANSI.
# TODO CONVERTIR EN SUBRUTINA

type setCursorPos, @function
.globl setCursorPos

setCursorPos:

push %ebp
movl %esp, %ebp

pushl %ebx

movl 8(%ebp), %ebx

# AH=fila, AL=columna
movw %ebx, %ax

# TODO AMPLIAR A DOS CARACTERES CADA POSICION
# Convertir a ACII
orb $0x30, %al
orb $0x30, %ah
# Actualizar codigo ANSI
movb %al, (%ebx+3)
movb %ah, (%ebx+6)

# TODO VALOR DE RETORNO

   jmp mainLoop
