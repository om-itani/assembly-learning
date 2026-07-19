section .data
    even_msg db "EVEN", 10
    even_len equ $ - even_msg

    odd_msg db "ODD", 10
    odd_len equ $ - odd_msg

section .text
    global _start

_start:
    mov rax, 7
    xor rdx, rdx
    mov rbx, 2
    div rbx

    cmp rdx, 0
    jz print_even

print_odd:
    mov rax, 1
    mov rdi, 1
    mov rsi, odd_msg
    mov rdx, odd_len 
    syscall

    jmp exit_program

print_even:
    mov rax, 1
    mov rdi, 1
    mov rsi, even_msg
    mov rdx, even_len
    syscall

exit_program:
    mov rax, 60
    xor rdi, rdi
    syscall



