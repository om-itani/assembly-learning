section .data
    hot_msg db "HOT!", 10
    hot_len equ $ - hot_msg

    cold_msg db "COLD", 10
    cold_len equ $ - cold_msg

section .text
    global _start

_start:
    mov rax, 35                  ; Our temperature variable (rax = 35)

    ; --- THE DECISION ---
    cmp rax, 30                  ; Compare rax to 30 (Calculates 35 - 30 = 5)
    jg print_hot                 ; 'jg' = Jump if Greater. Since 35 > 30, teleport to 'print_hot'

; If the jump didn't happen, execution falls through here:
print_cold:
    mov rax, 1                   ; sys_write
    mov rdi, 1                   ; stdout
    mov rsi, cold_msg            ; Print "COLD"
    mov rdx, cold_len
    syscall

    jmp exit_program             ; CRITICAL: We must jump past the "HOT" code,
                                 ; otherwise the CPU will run both!

print_hot:
    mov rax, 1                   ; sys_write
    mov rdi, 1                   ; stdout
    mov rsi, hot_msg             ; Print "HOT!"
    mov rdx, hot_len
    syscall

exit_program:
    mov rax, 60                  ; sys_exit
    xor rdi, rdi                 ; return 0
    syscall 