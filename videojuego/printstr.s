.global print_str

# Mostrar una cadena de texto por pantalla.
# Argumentos:
#    1. cadena de texto a mostrar.
# Devuelve:
#    Devuelve en numero de bytes mostrados.
print_str:
    # Nuevo marco de pila, sin variables locales
    push %ebp
    movl %esp, %ebp
    # Salvaguardar registros que modificamos
    pushl %edx
    pushl %ecx
    pushl %ebx

    # Mostrar por pantalla
    movl 8(%ebp), %ecx # Cadena de texto (1er parametro)
    push %ecx
    call len_str       # Longitud de la cadena
    movl %eax, %edx
    movl $4, %eax      # Escribir
    movl $1, %ebx      # por pantalla (stdout)
    int $0x80

    # Recuperar registros
    popl %ebx
    popl %ecx
    popl %edx
    # Recuperar marco de pila
    movl %ebp, %esp
    popl %ebp
    # Retornar, eax proporcionado por interrupcion
    ret $4
