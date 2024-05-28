# Devuelve el numero de caracteres de una cadena de texto ASCII.
# Argumentos:
#    1. cadena de texto acabada en 0 (NULL).
# Devuelve:
#    Devuelve en numero de caracteres (bytes) de la cadena (sin contar NULL).

.global len_str
len_str:
    # Nuevo marco de pila, sin variables locales
    enter $0, $0
    # Salvaguardar registros que modificamos
    pushl %ecx
    pushl %ebx

    movl 8(%ebp), %ebx # Cadena de texto (1er parametro)
    xorl %eax, %eax    # Valor de retorno en eax
 countchar:
    movb (%ebx, %eax), %cl
    incl %eax
    cmpb $0, %cl
    jne countchar
    decl %eax  # Descontar caracter NULL

    # Recuperar registros
    popl %ebx
    popl %ecx
    # Recuperar marco de pila
    leave
    # Retornar
    ret $4
