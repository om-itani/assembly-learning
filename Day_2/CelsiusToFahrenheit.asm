section .data
    ; We pre-format a text template in memory.
    ; '00' is a placeholder where we will inject our output digits.
    result_msg db "Fahrenheit: 00", 10
    msg_len equ $ - result_msg

section .text
    global _start

_start:
    ; We will use registers as our temporary "variables"
    mov rax, 25                 ; Variable 'celsius' = 25 (stored in rax)

    ; 1. Multiply celsius by 9
    mov rbx, 9                  ; Load multiplier (9) intro rbx
    mul rbx                     ; Multiplies RAX by RBX. Result is saved back into RAX (225)

    ; 2. Divide by 5
    mov rbx, 5
    xor rdx, rdx                ; Clear rdx (required before division)
    div rbx                     ; Divides RAX by RBX. Result is saved in RAX (45)

    ; 3. Add 32
    add rax, 32                 ; Adds 32 directly to RAX (77)

    ; --- Convert the integer 77 into ASCII characters '7' and '7' to print them ---
    mov rbx, 10
    xor rdx, rdx
    div rbx                     ; Divide 77 by 10. RAX = 7 (tens), RDX = 7 (ones)

    add al, '0'                 ; Convert digit 7 to ASCII character '7'
    add dl, '0'                 ; Convert digit 7 to ASCII character '7'

    ; Inject characters directly into our text template in memory
    mov [result_msg + 12], al   ; Place '7' into the first '0' placeholder
    mov [result_msg + 13], dl   ; Place '7' into the second '0' placeholder

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