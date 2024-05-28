@echo off
as --32 laberintoBASE.s -o lab.o
as --32 printstr.s -o printstr.o
as --32 strtoul.s -o strtoul.o
as --32 len_str.s -o len_str.o
ld -melf_i386 lab.o printstr.o strtoul.o len_str.o -o ej
./ej
