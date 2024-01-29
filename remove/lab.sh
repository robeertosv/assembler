mkdir eraseThis
nasm -f elf32 erase.asm -o erase.o
ld -m elf_i386 erase.o -o erase
