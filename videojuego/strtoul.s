# Devuelve un entero sin signo a partir de una cadena de texto.
# Argumentos:
#    1. cadena de texto ASCII acabada en NULL.
# Devuelve:
#    Devuelve el decimal sin signo de la cadena 
#    o 0xFFFF si hay desbordamiento o la cadena no es valida.

.global str_to_ul
str_to_ul:
    # Nuevo marco de pila, sin variables locales
    enter $0, $0
    # Salvaguardar registros que modificamos
    pushl %ebx
    pushl %ecx
    pushl %edx
    pushl %esi

    movl 8(%ebp), %ebx # Cadena de texto (1er parametro)
    pushl %ebx
    call len_str       # Longitud de la cadena
    movl %eax, %ecx
    xorl %eax, %eax
    xorl %edx, %edx
    xorl %esi, %esi
    movl $10, %edi
  nextdigit:
    mull %edi  # mul edx|eax=edi*eax
    jc overror
    movb (%ebx, %esi), %dl
	cmpb $'0', %dl
    jb overror
    cmpb $'9', %dl
    ja overror
    andb $0x0F, %dl  # subb $'0',%dl
    addl %edx, %eax
    jc overror
    incl %esi
    cmpl %ecx, %esi
    jne nextdigit
    # No hay desbordamiento
    jmp endstrul
 overror:
    movl $0xFFFF, %eax

 endstrul:
    # Recuperar registros
    popl %esi
    popl %edx
    popl %ecx
    popl %ebx
    # Recuperar marco de pila
    leave
    # Retornar
    ret $4

