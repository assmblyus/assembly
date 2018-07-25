global _start

SECTION .data
location: db "./assemblyDIR"

SECTION .text

_start:
	MOV RDI, location
	MOV RAX, 0x53
	syscall

	MOV RDI, 0x0
	MOV RAX, 0x3c
	syscall
