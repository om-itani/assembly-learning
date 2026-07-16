section .data
    ; We pre-format a text template in memory.
    ; '00' is a placeholder where we will inject our output digits.
    result_msg db "Celsius: 00", 10
    msg_len equ $ - result_msg

section .text
    global _start

_start:
    ; 1. Load our starting temperature (95) into RAX
    mov rax, 95                 ; rax = 95

    ; 2. Subtract 32
    sub rax, 32                 ; rax = 95 - 32 = 63

    ; 3. Multiplty by 5
    mov rbx, 5                  ; Load 5 into rbx
    mul rbx                     ; rax = rax * rbx -> 63 * 5 = 315

    ; 4. Divide by 9
    mov rbx, 9                  ; Load 9 into rbx
    xor rdx, rdx                ; Clear rdx
    div rbx                     ; rax = rax / 9 -> 315 / 9 = 35
                                ; rdx = remainder (0)

    ; --- Convert the integer 35 into ASCII characters '3' and '5' to print them ---
    mov rbx, 10
    xor rdx, rdx
    div rbx                     ; Divide 35 by 10. RAX = 3 (tens), RDX = 5 (ones)

    add al, '0'                 ; Convert digit 3 to ASCII character '3'
    add dl, '0'                 ; Convert digit 5 to ASCII character '5'

    ; Inject characters directly into our text template in memory
    mov [result_msg + 9], al   ; Place '3' into the first '0' placeholder
    mov [result_msg + 10], dl   ; Place '5' into the second '0' placeholder

    ; --- Print result_msg to screen ---
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    mov rsi, result_msg         ; pointer to our updated string
    mov rdx, msg_len            ; length
    syscall

    ; --- Exit ---
    mov rax, 60                 ; sys_exit
    xor rdi, rdi                ; return 0
    syscall