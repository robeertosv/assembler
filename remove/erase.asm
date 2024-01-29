section .data
;folder db "/home/roberto/asm/remove/eraseThis", 0
folder db "eraseThis",0
msg db "Carpeta borrada", 0

section .text
global _start

_start:

mov eax, 0x28
mov ebx, folder
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx, 16
int 0x80

mov eax, 1
mov ebx, 0
int 0x80
