section .data
    msg db "Hello, World!", 10 ; 'db' means define bytes. 10 is the ASCII code for a new line '\n'.
    msg_len equ $ - msg        ; Dynamically calculates the number of characters in 'msg'.

section .text
    global _start               ; Tells the assembler where the program entry point is.

_start:
    ; 1. Tell the CPU to write to the screen
    mov rax, 1                   ; System call number 1 is 'sys_write'
    mov rdi, 1                   ; Destination index (1 = Standard Output / Screen)
    mov rsi, msg                 ; Source index (Memory address where our message starts)
    mov rdx, msg_len             ; Data register (How many bytes to print)
    syscall                      ; Trigger a system call to the operating system

    ; 2. Tell the CPU to safely exit the program
    mov rax, 60                  ; System call number 60 is 'sys_exit'
    xor rdi, rdi                 ; Set return code to 0 (Clear the rdi register)
    syscall                      ; Trigger system call to exit