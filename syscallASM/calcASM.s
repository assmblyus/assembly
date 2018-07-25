SECTION .data
	v1 dw '101', 0xa

SECTION .bss
	buffer: resb 10

SECTION .text
	global _start

_start:
	call converter_valor
	call mostrar_valor

_final:
	mov rdi, 0x0
	mov rax, 0x3c
	syscall

converter_valor:
	lea rsi, [v1]
	mov rcx, 3
	call string_to_int
	add rax, 1
	ret

mostrar_valor:
	lea rsi, [buffer]
	call int_to_string
	mov rax, 0x1
	mov rdi, 0x1
	mov rsi, buffer
	mov rdx, 10
	syscall
	ret

string_to_int:
	xor rbx, rbx
.prox_digito:
	movzx rax, byte[rsi]
	inc rsi
	sub al, '0'
	imul rbx, 10
	add rbx, rax
	loop .prox_digito
	mov rax, rbx
	ret

int_to_string:
	add rsi, 9
	mov byte [rsi], 0
	mov rbx, 10
.prox_digito:
	xor rdx, rdx
	div rbx
	add dl, '0'
	dec esi
	mov [rsi], dl
	test rax, rax
	jnz .prox_digito
	mov rax, rsi
	ret