section .data
name db "carpeta", 0
mensaje db "Carpeta creada correctamente", 0

section .text
global _start

_start:

mov eax, 0x27
mov ebx, name
mov ecx, 0
int 0x80

mov eax, 0x0f
mov ebx, name
mov ecx, 0xfff
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, mensaje
mov edx, 30
int 0x80

mov eax, 1
mov ebx, 0
int 0x80
