SECTION .data

array dd 89, 10, 11, 22
wordvar dd 123

SECTION .text
global _start

_start:
	mov rax, [wordvar]
	mov rbx, [array+1*4]
	syscall

	MOV RDI, 0x0
	MOV RAX, 0x3c
	syscall