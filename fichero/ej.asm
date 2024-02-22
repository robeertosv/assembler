.data
    reqName: .ascii "Introduce tu nombre: "
    lenReqName = . - reqName
    reqAge: .ascii "Introduce tu edad: "
    lenReqAge = . - reqAge

    repMsg: .ascii "Pulsa 'S' para salir o enter para continuar: "
    lenRepMsg = . - repMsg
    res: .space 2
    name: .space 10
    age: .space 10
    TAB: .ascii "\t"
    LF: .ascii "\n"

    dir: .string "./data.txt"
.text
.globl _start

_start:

movl $4, %eax
movl $1, %ebx
movl $reqName, %ecx
movl $lenReqName, %edx
int $0x80

movl $3, %eax
movl $0, %ebx
movl $name, %ecx
movl $10, %edx
int $0x80

dec %eax
movl %eax, %esi

movl $4, %eax
movl $1, %ebx
movl $reqAge, %ecx
movl $lenReqAge, %edx
int $0x80

movl $3, %eax
movl $0, %ebx
movl $age, %ecx
movl $10, %edx
int $0x80

movl %eax, %edi

movl $5, %eax
movl $dir, %ebx
movl $(01|02000|0100), %ecx
movl $0666, %edx
int $0x80

movl %eax, %ebp

movl $4, %eax
movl %ebp, %ebx
movl $name, %ecx
movl %esi, %edx
int $0x80

movl $4, %eax
movl %ebp, %ebx
movl $TAB, %ecx
movl $1, %edx
int $0x80

movl $4, %eax
movl %ebp, %ebx
movl $age, %ecx
movl %edi, %edx
int $0x80

movl $4, %eax
movl %ebp, %ebx
movl $LF, %ecx
movl $1, %edx
int $0x80

movl $6, %eax
movl %ebp, %ebx
int $0x80

movl $4, %eax
movl $1, %ebx
movl $repMsg, %ecx
movl $lenRepMsg, %edx
int $0x80

movl $3, %eax
movl $0, %ebx
movl $res, %ecx
movl $2, %edx
int $0x80

cmpl $'S\n', res
je end
jne _start

end:
movl $1, %eax
movl $0, %ebx
int $0x80
