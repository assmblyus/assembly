global _start

SECTION .data
location: db "./arch.s"

SECTION .text

_start:
	MOV RDI, location
	MOV RAX, 0x57
	syscall

	MOV RDI, 0x0
	MOV RAX, 0x3c
	syscall
